import 'package:dartz/dartz.dart';
import 'package:tarwika/core/class/crud.dart';
import 'package:tarwika/core/services/dependency_injection.dart';
import '../../core/class/parent_state.dart';
import '../../core/constant/app_link.dart';

class CategoryRemoteData {
  final _crud = AppDependency.getIt<Crud>();

  Future<Either<ParentState, Map>> view({
    required Map data,
    required String token,
  }) async {
    var response = await _crud.getData(
      linkUrl: AppLink.categoryView,
      token: token,
    );
    return response;
  }
}
