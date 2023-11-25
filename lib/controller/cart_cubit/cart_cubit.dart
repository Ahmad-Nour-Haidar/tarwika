import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarwika/core/constant/app_keys_request.dart';
import 'package:tarwika/core/constant/app_local_data.dart';
import '../../core/services/dependency_injection.dart';
import '../../data/remote/cart_data.dart';
import '../../model/cart_model.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitialState());

  static CartCubit get(BuildContext context) => BlocProvider.of(context);
  final cartRemoteData = AppDependency.getIt<CartRemoteData>();

  List<CartModel> dataModel = [];

  Future<void> initial() async {
    viewData();
  }

  int get totalCount {
    int c = 0;
    for (final element in dataModel) {
      c += element.count ?? 0;
    }
    return c;
  }

  int get totalPrice {
    int c = 0;
    for (final element in dataModel) {
      c += element.totalPrice ?? 0;
    }
    return c;
  }

  Future<void> onRefresh() async {
    viewData();
  }

  Future<void> viewData() async {
    emit(CartLoadingState());
    final token = AppLocalData.user!.token!;
    final response = await cartRemoteData.view(data: {}, token: token);
    if (isClosed) return;
    response.fold((l) {
      emit(CartFailureState(l));
    }, (response) {
      List tempData = response[AppRKeys.data];
      dataModel.clear();
      dataModel.addAll(tempData.map((e) => CartModel.fromJson(e)));
      emit(CartSuccessState());
    });
  }

  Future<void> delete(CartModel model) async {
    emit(CartLoadingState());
    final response = await cartRemoteData.delete(
      cartId: model.id.toString(),
    );
    if (isClosed) return;
    response.fold((l) {
      emit(CartFailureState(l));
    }, (r) {
      dataModel.removeWhere((element) => element.id == model.id!);
      emit(CartSuccessState());
    });
  }
}
