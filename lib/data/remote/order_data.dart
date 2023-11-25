import 'package:dartz/dartz.dart';
import 'package:tarwika/core/class/crud.dart';
import 'package:tarwika/core/services/dependency_injection.dart';
import '../../core/class/parent_state.dart';
import '../../core/constant/app_link.dart';

class OrderRemoteData {
  final _crud = AppDependency.getIt<Crud>();

  Future<Either<ParentState, Map>> view({
    required String token,
  }) async {
    var response = await _crud.getData(
      linkUrl: AppLink.orderView,
      token: token,
    );
    return response;
  }

  Future<Either<ParentState, Map>> order({
    required Map data,
    required String token,
  }) async {
    var response = await _crud.postData(
      linkUrl: AppLink.orderOrder,
      token: token,
      data: data,
    );
    return response;
  }

  Future<Either<ParentState, Map>> details({
    required String token,
    required String orderId,
  }) async {
    final link = '${AppLink.orderDetails}/$orderId';
    var response = await _crud.getData(
      linkUrl: link,
      token: token,
    );
    return response;
  }
}
