import 'package:dartz/dartz.dart';
import 'package:tarwika/core/class/crud.dart';
import 'package:tarwika/core/services/dependency_injection.dart';
import '../../core/class/parent_state.dart';
import '../../core/constant/app_keys_request.dart';
import '../../core/constant/app_link.dart';
import '../../core/constant/app_local_data.dart';
import '../../model/item_model.dart';

class FavoriteRemoteData {
  final _crud = AppDependency.getIt<Crud>();

  Future<Either<ParentState, Map>> view({
    required String token,
  }) async {
    var response = await _crud.getData(
      linkUrl: AppLink.favoriteView,
      token: token,
    );
    return response;
  }

  Future<Either<ParentState, Map>> add({
    required Map data,
    required String token,
  }) async {
    var response = await _crud.postData(
      data: data,
      linkUrl: AppLink.favoriteAdd,
      token: token,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> delete({
    required Map data,
    required String token,
    required String itemId,
  }) async {
    final link = '${AppLink.favoriteDelete}/$itemId';
    var response = await _crud.deleteData(
      data: data,
      linkUrl: link,
      token: token,
    );
    return response;
  }

  Future<ParentState> onTapFav(ItemModel itemModel) async {
    if (itemModel.isFavorite!) {
      return await removeFromFav(itemModel);
    } else {
      return await addToFav(itemModel);
    }
  }

  Future<ParentState> addToFav(ItemModel itemModel) async {
    itemModel.isFavorite = true;
    final data = {
      AppRKeys.item_id: itemModel.id.toString(),
    };
    final token = AppLocalData.user!.token!;
    final response = await add(
      data: data,
      token: token,
    );
    late ParentState state;
    response.fold((l) {
      itemModel.isFavorite = false;
      state = l;
    }, (r) {
      itemModel.isFavorite = true;
      state = SuccessState('');
    });
    return state;
  }

  Future<ParentState> removeFromFav(ItemModel itemModel) async {
    itemModel.isFavorite = false;
    final token = AppLocalData.user!.token!;
    final response = await delete(
      data: {},
      token: token,
      itemId: itemModel.id.toString(),
    );
    late ParentState state;
    response.fold((l) {
      itemModel.isFavorite = true;
      state = l;
    }, (r) {
      itemModel.isFavorite = false;
      state = SuccessState('');
    });
    return state;
  }
}
