import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tarwika/core/constant/app_keys.dart';
import 'package:tarwika/core/constant/app_keys_request.dart';
import 'package:tarwika/core/constant/app_local_data.dart';
import 'package:tarwika/core/functions/functions.dart';
import 'package:tarwika/data/remote/order_data.dart';
import 'package:tarwika/model/order_details_model.dart';
import 'package:tarwika/model/order_model.dart';
import '../../core/constant/app_strings.dart';
import '../../core/services/dependency_injection.dart';
import '../../model/screen_arguments.dart';
import 'order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit() : super(OrderDetailsInitialState());

  static OrderDetailsCubit get(BuildContext context) =>
      BlocProvider.of(context);
  final orderRemoteData = AppDependency.getIt<OrderRemoteData>();
  List<OrderDetailsModel> data = [];
  late OrderModel orderModel;
  late List<Map<String, String>> textList;

  String get time =>
      formatDateJiffy(DateTime.parse(orderModel.reservationDateTime!));

  String get date =>
      formatTimeJiffy(DateTime.parse(orderModel.reservationDateTime!));

  void initial(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    orderModel = args.args[AppKeys.orderModel];
    final id =
        isEnglish() ? '${AppStrings.id.tr} : # ' : '${AppStrings.id.tr} : # ';
    textList = [
      {'s1': id, 's2': '${orderModel.id}'},
      {
        's1': '${AppStrings.persons.tr} : ',
        's2': orderModel.persons.toString()
      },
      {
        's1': '${AppStrings.meals.tr} : ',
        's2': orderModel.totalCount.toString()
      },
      {
        's1': '${AppStrings.totalPrice.tr} : ',
        's2': '${orderModel.totalPrice} S.P'
      },
      {'s1': '${AppStrings.time.tr} : ', 's2': time},
      {'s1': '${AppStrings.date.tr} : ', 's2': date},
    ];
    getData();
  }

  Future<void> getData() async {
    emit(OrderDetailsLoadingState());
    final token = AppLocalData.user!.token!;
    final id = orderModel.id.toString();
    final response = await orderRemoteData.details(token: token, orderId: id);
    response.fold((l) {
      emit(OrderDetailsFailureState(l));
    }, (r) {
      final List tempData = r[AppRKeys.data];
      data.clear();
      data.addAll(tempData.map((e) => OrderDetailsModel.fromJson(e)));
      emit(OrderDetailsSuccessState());
    });
  }
}
