import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tarwika/controller/current_order_details_cubit/current_order_details_state.dart';
import 'package:tarwika/core/constant/app_keys_request.dart';
import 'package:tarwika/core/constant/app_local_data.dart';
import 'package:tarwika/core/extensions/with_time.dart';
import 'package:tarwika/data/remote/order_data.dart';
import '../../core/class/parent_state.dart';
import '../../core/constant/app_strings.dart';
import '../../core/functions/functions.dart';
import '../../core/services/dependency_injection.dart';
import '../../data/remote/cart_data.dart';

class CurrentOrderDetailsCubit extends Cubit<CurrentOrderDetailsState> {
  CurrentOrderDetailsCubit() : super(CurrentOrderDetailsInitialState());

  static CurrentOrderDetailsCubit get(BuildContext context) =>
      BlocProvider.of(context);
  final orderRemoteData = AppDependency.getIt<OrderRemoteData>();
  final cartRemoteData = AppDependency.getIt<CartRemoteData>();
  late String _token;
  int? totalCount, totalPrice, numberPersons;
  DateTime? reservationDateTime, reservationDate, reservationTime;

  void initial() {
    _token = AppLocalData.user!.token!;
    initialNull();
    emit(CurrentOrderDetailsInitialState());
  }

  void changeDate(DateTime date) {
    reservationDate = date;
    reservationDateTime = date;
    if (reservationTime != null) {
      reservationDateTime = date.withTime(
        reservationTime!.hour,
        reservationTime!.minute,
      );
    }
    emit(CurrentOrderDetailsChangeState());
  }

  void changeTime(DateTime time) {
    reservationTime = time;
    if (reservationDate != null) {
      reservationDateTime = reservationDate!.withTime(time.hour, time.minute);
    }
    emit(CurrentOrderDetailsChangeState());
  }

  void changeNumberPersons(int value) {
    numberPersons = value;
    emit(CurrentOrderDetailsChangeState());
  }

  String get name => AppLocalData.user!.data!.name!;

  String get phone => AppLocalData.user!.data!.phone!;

  String get date {
    if (reservationDate != null) {
      return formatDateJiffy(reservationDate!);
      // return AppLocalData.formatDate.format(reservationDate!);
    }
    return AppStrings.tapHereToSetDate.tr;
  }

  String get time {
    if (reservationTime != null) {
      return formatTimeJiffy(reservationTime!);
      // return AppLocalData.formatTime.format(reservationTime!);
    }
    return AppStrings.tapHereToSetTime.tr;
  }

  String get getNumberPersons {
    if (numberPersons != null) return numberPersons.toString();
    return AppStrings.tapHereToSetNumberPersons.tr;
  }

  Future<void> initialCountItems() async {
    final response = await cartRemoteData.countItems(data: {}, token: _token);
    response.fold((l) {
      totalCount = null;
    }, (r) {
      final Map data = r[AppRKeys.data];
      totalCount = int.parse(data[AppRKeys.count].toString());
      totalPrice = int.parse(data[AppRKeys.total_price].toString());
    });
  }

  Future<void> order() async {
    if (reservationDate == null ||
        reservationTime == null ||
        numberPersons == null) {
      emit(
        CurrentOrderDetailsFailureState(
          FailureState(AppStrings.setDateTimeAndNumberOfPersons.tr),
        ),
      );
      return;
    }
    emit(CurrentOrderDetailsLoadingState());
    if (totalCount == null) {
      await initialCountItems();
    }
    if (totalCount == null) {
      emit(
        CurrentOrderDetailsFailureState(
          FailureState(AppStrings.somethingWentWrong.tr),
        ),
      );
      return;
    }
    if (totalCount == 0) {
      emit(
        CurrentOrderDetailsFailureState(
          FailureState(AppStrings.yourOrderIsEmpty.tr),
        ),
      );
      totalCount = null;
      totalPrice = null;
      return;
    }
    final data = {
      AppRKeys.total_price: totalPrice,
      AppRKeys.total_count: totalCount,
      AppRKeys.reservation_date_time: reservationDateTime.toString(),
      AppRKeys.persons: numberPersons,
    };
    final response = await orderRemoteData.order(data: data, token: _token);
    response.fold((l) {
      emit(CurrentOrderDetailsFailureState(l));
    }, (r) {
      emit(CurrentOrderDetailsSuccessState(SuccessState(AppStrings.done.tr)));
      initialNull();
    });
  }

  void initialNull() {
    totalCount = null;
    totalPrice = null;
    numberPersons = null;
    reservationTime = null;
    reservationDate = null;
    reservationDateTime = null;
  }
}
