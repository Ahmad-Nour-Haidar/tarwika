import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarwika/core/constant/app_keys_request.dart';
import 'package:tarwika/core/constant/app_local_data.dart';
import 'package:tarwika/data/remote/favorite_data.dart';
import '../../core/services/dependency_injection.dart';
import '../../model/item_model.dart';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitialState());

  static FavoriteCubit get(BuildContext context) => BlocProvider.of(context);
  final favoriteRemoteData = AppDependency.getIt<FavoriteRemoteData>();

  void onTapFav(ItemModel itemModel) {
    if (itemModel.isFavorite!) {
      removeFromFav(itemModel);
    } else {
      addToFav(itemModel);
    }
  }

  void addToFav(ItemModel itemModel) async {
    itemModel.isFavorite = true;
    emit(FavoriteLoadingState());
    final data = {
      AppRKeys.item_id: itemModel.id,
    };
    final token = AppLocalData.user!.token!;
    final response = await favoriteRemoteData.add(
      data: data,
      token: token,
    );
    response.fold((l) {
      itemModel.isFavorite = false;
      emit(FavoriteFailureState(l));
    }, (r) {
      itemModel.isFavorite = true;
      emit(FavoriteSuccessState());
    });
  }

  void removeFromFav(ItemModel itemModel) async {
    itemModel.isFavorite = false;
    emit(FavoriteLoadingState());
    final token = AppLocalData.user!.token!;
    final response = await favoriteRemoteData.delete(
      data: {},
      token: token,
      itemId: itemModel.id.toString(),
    );
    response.fold((l) {
      itemModel.isFavorite = true;
      emit(FavoriteFailureState(l));
    }, (r) {
      itemModel.isFavorite = false;
      emit(FavoriteSuccessState());
    });
  }
}
