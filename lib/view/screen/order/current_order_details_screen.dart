import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tarwika/core/constant/app_size.dart';
import 'package:tarwika/core/constant/app_strings.dart';
import 'package:tarwika/core/constant/app_svg.dart';
import 'package:tarwika/routes.dart';
import 'package:tarwika/view/widget/custom_drawer.dart';
import 'package:tarwika/view/widget/handle_state.dart';
import 'package:tarwika/view/widget/order_info/card_details_widget.dart';
import '../../../controller/current_order_details_cubit/current_order_details_cubit.dart';
import '../../../controller/current_order_details_cubit/current_order_details_state.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/functions/navigator.dart';
import '../../../core/resources/app_text_theme.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_button.dart';

class CurrentOrderDetailsScreen extends StatelessWidget {
  const CurrentOrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    CurrentOrderDetailsCubit.get(context).initial();
    return BlocConsumer<CurrentOrderDetailsCubit, CurrentOrderDetailsState>(
      listener: (context, state) {
        if (state is CurrentOrderDetailsFailureState) {
          handleState(context: context, state: state.state);
        }
      },
      builder: (context, state) {
        final cubit = CurrentOrderDetailsCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: CustomAppBar(
            key: scaffoldKey,
            title: AppStrings.currentOrderDetails.tr,
            backgroundColor: AppColor.primaryColor,
          ).build(context),
          drawer: const CustomDrawer(showCurrentOrderB: false),
          body: Column(
            children: [
              if (state is CurrentOrderDetailsSuccessState)
                FadeInDown(
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    margin: const EdgeInsets.only(bottom: 10),
                    width: AppSize.width,
                    decoration: const BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(AppSize.radius65),
                        bottomRight: Radius.circular(AppSize.radius65),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.success.tr,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: AppColor.white,
                          ),
                        ),
                        const SizedBox(height: 15),
                        SvgPicture.asset(AppSvg.done)
                      ],
                    ),
                  ),
                ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(AppSize.screenPadding),
                  children: [
                    const SizedBox(height: 10),
                    CardDetailsWidget(
                      title: AppStrings.name.tr,
                      subtitle: cubit.name,
                    ),
                    const SizedBox(height: 20),
                    CardDetailsWidget(
                      title: AppStrings.phone.tr,
                      subtitle: cubit.phone,
                    ),
                    const SizedBox(height: 20),
                    CardDetailsWidget(
                      title: AppStrings.date.tr,
                      subtitle: cubit.date,
                      onTap: () {
                        pushNamed(AppRoute.dateTimePeople, context);
                      },
                    ),
                    const SizedBox(height: 20),
                    CardDetailsWidget(
                      title: AppStrings.time.tr,
                      subtitle: cubit.time,
                      onTap: () => pushNamed(AppRoute.dateTimePeople, context),
                    ),
                    const SizedBox(height: 20),
                    CardDetailsWidget(
                      onTap: () => pushNamed(AppRoute.dateTimePeople, context),
                      title: AppStrings.numberPersons.tr,
                      subtitle: cubit.getNumberPersons,
                    ),
                    const SizedBox(height: 20),
                    CardDetailsWidget(
                      onTap: () => pushNamed(AppRoute.cartScreen, context),
                      title: AppStrings.mealsOrdered.tr,
                      subtitle: AppStrings.tapHereToSeeDetails.tr,
                    ),
                    const SizedBox(height: 40),
                    if (state is CurrentOrderDetailsLoadingState)
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: SpinKitThreeBounce(color: AppColor.buttonColor),
                      ),
                    if (state is! CurrentOrderDetailsLoadingState)
                      CustomButton(
                        width: AppSize.width * .75,
                        elevation: 0,
                        text: AppStrings.order.tr,
                        onTap: cubit.order,
                        style: AppTextTheme.f24w600black,
                        color: AppColor.buttonColor,
                        height: AppSize.size40,
                        radius: AppSize.radius20,
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
