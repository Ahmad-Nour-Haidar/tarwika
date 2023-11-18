import 'package:dartz/dartz.dart';
import 'package:tarwika/core/class/crud.dart';
import 'package:tarwika/core/services/dependency_injection.dart';
import '../../core/class/parent_state.dart';
import '../../core/constant/app_link.dart';

class ItemRemoteData {
  final _crud = AppDependency.getIt<Crud>();

  Future<Either<ParentState, Map>> view({
    required String token,
    required int categoryId,
  }) async {
    final link = '${AppLink.itemView}/$categoryId';
    final response = await _crud.getData(
      linkUrl: link,
      token: token,
    );
    return response;
  }

  Future<Either<ParentState, Map>> search({
    required String token,
    required String value,
  }) async {
    final params = {
      'filter[search]': value,
    };
    // final queryString =Uri.encodeQueryComponent(value);
    final link = '${AppLink.itemSearch}?filter[search]=$value';
    final response = await _crud.getData(
      linkUrl: link,
      token: token,
    );
    return response;
  }
}
