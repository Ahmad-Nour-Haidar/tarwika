import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarwika/core/constant/app_keys_request.dart';
import 'package:tarwika/core/constant/app_local_data.dart';
import 'package:tarwika/data/remote/favorite_data.dart';
import '../../core/class/parent_state.dart';
import '../../core/services/dependency_injection.dart';
import '../../model/item_model.dart';
import 'favorite_screen_state.dart';

class FavoriteScreenCubit extends Cubit<FavoriteScreenState> {
  FavoriteScreenCubit() : super(FavoriteScreenInitialState());

  static FavoriteScreenCubit get(BuildContext context) =>
      BlocProvider.of(context);
  final favoriteRemoteData = AppDependency.getIt<FavoriteRemoteData>();
  List<ItemModel> data = [];

  void initial() {
    view();
  }

  Future<void> view() async {
    emit(FavoriteScreenLoadingState());
    final token = AppLocalData.user!.token!;
    final response = await favoriteRemoteData.view(token: token);
    response.fold((l) {
      emit(FavoriteScreenFailureState(l));
    }, (r) {
      List temp = r[AppRKeys.data];
      data.clear();
      data.addAll(temp.map((e) => ItemModel.fromJson(e)));
      emit(FavoriteScreenSuccessState());
    });
  }

  void onTapFav(ItemModel model, BuildContext context) async {
    final result = await favoriteRemoteData.onTapFav(model);
    if (result is FailureState) {
      emit(FavoriteScreenFailureState(result));
    } else if (result is SuccessState) {
      data.removeWhere((element) => element.id == model.id);
      emit(FavoriteScreenSuccessState());
    }
  }
}
