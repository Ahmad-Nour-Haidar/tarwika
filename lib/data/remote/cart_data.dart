import 'package:dartz/dartz.dart';
import 'package:tarwika/core/class/crud.dart';
import 'package:tarwika/core/services/dependency_injection.dart';
import '../../core/class/parent_state.dart';
import '../../core/constant/app_link.dart';

class CartRemoteData {
  final _crud = AppDependency.getIt<Crud>();

  Future<Either<ParentState, Map>> view({
    required Map data,
    required String token,
  }) async {
    var response = await _crud.getData(
      linkUrl: AppLink.cartView,
      token: token,
    );
    return response;
  }

  Future<Either<ParentState, Map>> countItems({
    required Map data,
    required String token,
  }) async {
    var response = await _crud.getData(
      linkUrl: AppLink.cartCountItems,
      token: token,
    );
    return response;
  }

  Future<Either<ParentState, Map>> store({
    required Map data,
    required String token,
  }) async {
    var response = await _crud.postData(
      linkUrl: AppLink.cartStore,
      token: token,
      data: data,
    );
    return response;
  }

  Future<Either<ParentState, Map>> getDetails({
    required String itemId,
    required String token,
  }) async {
    var response = await _crud.getData(
      linkUrl: '${AppLink.cartGetDetailsItem}/$itemId',
      token: token,
    );
    return response;
  }

  Future<Either<ParentState, Map>> delete({
    required String cartId,
  }) async {
    var response = await _crud.deleteData(
      linkUrl: '${AppLink.cartDelete}/$cartId',
      data: {},
    );
    return response;
  }
}
