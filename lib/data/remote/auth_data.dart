import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tarwika/core/class/crud.dart';
import 'package:tarwika/core/class/parent_state.dart';
import 'package:tarwika/core/constant/app_keys_request.dart';
import 'package:tarwika/core/services/dependency_injection.dart';
import '../../core/constant/app_link.dart';

class AuthRemoteData {
  final _crud = AppDependency.getIt<Crud>();

  Future<Either<ParentState, Map<String, dynamic>>> login({
    required Map data,
  }) async {
    var response = await _crud.postData(
      data: data,
      linkUrl: AppLink.login,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> register({
    required Map data,
  }) async {
    var response = await _crud.postData(
      data: data,
      linkUrl: AppLink.register,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> verify({
    required Map data,
  }) async {
    var response = await _crud.postData(
      data: data,
      linkUrl: AppLink.verifyCode,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> checkEmail({
    required Map data,
  }) async {
    var response = await _crud.postData(
      data: data,
      linkUrl: AppLink.checkEmail,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> resetPassword({
    required Map data,
  }) async {
    var response = await _crud.postData(
      data: data,
      linkUrl: AppLink.resetPassword,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> edit({
    required Map<String, dynamic> data,
    required String token,
    File? file,
  }) async {
    if (file == null) {
      return await _crud.postData(
        data: data,
        token: token,
        linkUrl: AppLink.edit,
      );
    }
    return await _crud.postRequestWithFile(
      data: data,
      token: token,
      linkUrl: AppLink.edit,
      file: file,
      nameKey: AppRKeys.image,
    );
  }
}
