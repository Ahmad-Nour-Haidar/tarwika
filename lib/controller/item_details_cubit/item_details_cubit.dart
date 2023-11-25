import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tarwika/core/class/parent_state.dart';
import 'package:tarwika/core/constant/app_constant.dart';
import 'package:tarwika/core/constant/app_keys_request.dart';
import 'package:tarwika/core/constant/app_local_data.dart';
import 'package:tarwika/core/constant/app_strings.dart';
import 'package:tarwika/core/services/dependency_injection.dart';
import 'package:tarwika/data/remote/cart_data.dart';
import 'package:tarwika/model/item_model.dart';
import 'package:tarwika/model/screen_arguments.dart';
import '../../core/constant/app_keys.dart';
import '../../model/item_other_details_model.dart';
import 'item_details_state.dart';

class ItemDetailsCubit extends Cubit<ItemDetailsState> {
  ItemDetailsCubit() : super(ItemDetailsInitialState(NoneState('')));

  static ItemDetailsCubit get(BuildContext context) => BlocProvider.of(context);
  final cartRemoteData = AppDependency.getIt.get<CartRemoteData>();

  late ItemModel itemModel;
  late ItemOtherDetailsModel itemOtherDetails;
  int? count;

  String? size;

  void initial(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    itemModel = args.args[AppKeys.itemModel];
    final customData = {
      'id': 0,
      'order_id': 0,
      'user_id': AppLocalData.user!.data!.id!,
      'item_id': itemModel.id,
      'count': 0,
      'item_price': itemModel.price!.medium,
      'size': AppConstant.medium,
    };
    // itemOtherDetails = ItemOtherDetailsModel.fromJson(customData);
    getItemOtherDetailsModel(customData);
  }

  void getItemOtherDetailsModel(Map<String, dynamic> customData) async {
    emit(ItemDetailsLoadingDataState(NoneState('')));
    final response = await cartRemoteData.getDetails(
      itemId: '${itemModel.id}',
      token: AppLocalData.user!.token!,
    );
    if (isClosed) return;
    response.fold((l) {
      itemOtherDetails = ItemOtherDetailsModel.fromJson(customData);
      count = itemOtherDetails.count;
      size = itemOtherDetails.size;
      emit(ItemDetailsFailureState(l));
    }, (response) {
      var data = response[AppRKeys.data];
      data ??= customData;
      itemOtherDetails = ItemOtherDetailsModel.fromJson(data);
      count = itemOtherDetails.count;
      size = itemOtherDetails.size;
      emit(ItemDetailsSuccessState(NoneState('')));
    });
  }

  bool get hasMultiSize => itemModel.categoryName! == AppConstant.pizza;

  int get price {
    if (!hasMultiSize) {
      return itemModel.price!.medium!;
    }
    if (size! == AppConstant.small) {
      return itemModel.price!.small!;
    }
    if (size! == AppConstant.medium) {
      return itemModel.price!.medium!;
    }
    return itemModel.price!.large!;

    // if (itemOtherDetails.size! == AppConstant.small) {
    //   return itemModel.price!.small!;
    // }
    // if (itemOtherDetails.size! == AppConstant.medium) {
    //   return itemModel.price!.medium!;
    // }
    // return itemModel.price!.large!;
  }

  int get totalPrice => price * (count ??= 0);

  void changeCount(int x) {
    if (count! + x < 0) return;
    count = count! + x;
    count = count! < 0 ? 0 : count;
    emit(ItemDetailsChangeState(NoneState('')));
  }

  void changeSize(String s) {
    if (size! == s) return;
    size = s;
    emit(ItemDetailsChangeState(NoneState('')));
  }

  void store() async {
    emit(ItemDetailsLoadingState());
    final token = AppLocalData.user!.token!;
    final data = {
      AppRKeys.item_id: itemModel.id,
      AppRKeys.category_id: itemModel.categoryId,
      AppRKeys.size: size,
      AppRKeys.count: count,
    };
    final response = await cartRemoteData.store(
      data: data,
      token: token,
    );
    if (isClosed) return;
    response.fold((l) {
      emit(ItemDetailsFailureState(l));
    }, (r) {
      emit(ItemDetailsStoreSuccessState(SuccessState(AppStrings.done.tr)));
    });
  }
}
