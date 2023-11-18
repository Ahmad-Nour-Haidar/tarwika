import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarwika/controller/my_order_cubit/my_order_state.dart';
import 'package:tarwika/core/constant/app_keys_request.dart';
import 'package:tarwika/core/constant/app_local_data.dart';
import 'package:tarwika/data/remote/order_data.dart';
import '../../core/services/dependency_injection.dart';
import '../../model/order_model.dart';

class MyOrderCubit extends Cubit<MyOrderState> {
  MyOrderCubit() : super(MyOrderInitialState());

  static MyOrderCubit get(BuildContext context) => BlocProvider.of(context);
  final orderRemoteData = AppDependency.getIt<OrderRemoteData>();

  final List<OrderModel> data = [];

  void initial() {
    getData();
  }

  Future<void> onRefresh() async {
    getData();
  }

  Future<void> getData() async {
    emit(MyOrderLoadingState());
    final token = AppLocalData.user!.token!;
    final response = await orderRemoteData.view(token: token);
    response.fold((l) {
      emit(MyOrderFailureState(l));
    }, (r) {
      final List tempData = r[AppRKeys.data];
      data.clear();
      data.addAll(tempData.map((e) => OrderModel.fromJson(e)));
      emit(MyOrderSuccessState());
    });
  }
}
