import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tarwika/core/constant/app_color.dart';
import 'package:tarwika/core/constant/app_size.dart';
import 'package:tarwika/core/constant/app_strings.dart';
import 'package:tarwika/view/widget/custom_drawer.dart';
import 'package:tarwika/view/widget/order_info/time_widget.dart';
import '../../../controller/current_order_details_cubit/current_order_details_cubit.dart';
import '../../../controller/current_order_details_cubit/current_order_details_state.dart';
import '../../../core/resources/app_text_theme.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_button.dart';
import '../../widget/order_info/counter_persons_widget.dart';
import '../../widget/order_info/date_widget.dart';

class DateTimePeopleScreen extends StatelessWidget {
  const DateTimePeopleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocBuilder<CurrentOrderDetailsCubit, CurrentOrderDetailsState>(
      builder: (context, state) {
        final cubit = CurrentOrderDetailsCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: AppColor.primaryColor,
          appBar: CustomAppBar(
            key: scaffoldKey,
            title: AppStrings.orderInfo.tr,
            backgroundColor: AppColor.primaryColor,
          ).build(context),
          drawer: const CustomDrawer(
            showCurrentOrderB: false,
          ),
          body: FadeInUp(
            from: 200,
            duration: const Duration(milliseconds: 600),
            child:
                BlocBuilder<CurrentOrderDetailsCubit, CurrentOrderDetailsState>(
              builder: (context, state) {
                return Container(
                  padding: const EdgeInsets.all(AppSize.screenPadding),
                  decoration: const BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppSize.radius65),
                      topRight: Radius.circular(AppSize.radius65),
                    ),
                  ),
                  child: ListView(
                    children: [
                      const SizedBox(height: 10),
                      DateWidget(onChange: cubit.changeDate),
                      const SizedBox(height: 20),
                      TimeWidget(onChange: cubit.changeTime),
                      const SizedBox(height: 20),
                      CounterPersonsWidget(
                        onChange: cubit.changeNumberPersons,
                      ),
                      const SizedBox(height: 40),
                      CustomButton(
                        width: AppSize.width * .75,
                        elevation: 0,
                        text: AppStrings.done.tr,
                        onTap: () => Navigator.pop(context),
                        style: AppTextTheme.f24w600black,
                        color: AppColor.buttonColor,
                        height: AppSize.size40,
                        radius: AppSize.radius20,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
