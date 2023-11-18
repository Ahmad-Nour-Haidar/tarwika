import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tarwika/core/constant/app_lottie.dart';
import 'package:tarwika/core/constant/app_size.dart';
import 'package:tarwika/core/constant/app_strings.dart';
import 'package:tarwika/core/services/dependency_injection.dart';
import 'package:tarwika/view/widget/handle_state.dart';
import '../../../controller/my_order_cubit/my_order_cubit.dart';
import '../../../controller/my_order_cubit/my_order_state.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_drawer.dart';
import '../../widget/custom_loading_widget/loading_cart_item.dart';
import '../../widget/empty_widget.dart';
import '../../widget/order_info/my_order_widget.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocProvider(
      create: (_) => AppDependency.getIt<MyOrderCubit>()..initial(),
      child: BlocConsumer<MyOrderCubit, MyOrderState>(
        listener: (context, state) {
          if (state is MyOrderFailureState) {
            handleState(context: context, state: state.state);
          }
        },
        builder: (context, state) {
          final cubit = MyOrderCubit.get(context);
          Widget? body;
          if (state is MyOrderLoadingState) {
            body = LoadingCartItem(onRefresh: cubit.onRefresh);
          }
          if (state is MyOrderFailureState) {
            body = LottieBuilder.asset(AppLottie.oops);
          }
          if (state is MyOrderSuccessState && cubit.data.isEmpty) {
            body = EmptyWidget(
              text: AppStrings.youHaveNoOrderedYet.tr,
              lottie: AppLottie.listEmpty,
            );
          }
          if (state is MyOrderSuccessState && cubit.data.isNotEmpty) {
            body = RefreshIndicator(
              onRefresh: () async {
                cubit.getData();
              },
              child: ListView.separated(
                itemCount: cubit.data.length,
                padding: const EdgeInsets.all(AppSize.screenPadding),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20),
                itemBuilder: (context, index) =>
                    MyOrderWidget(model: cubit.data[index]),
              ),
            );
          }
          return Scaffold(
            key: scaffoldKey,
            appBar: CustomAppBar(
              key: scaffoldKey,
              title: AppStrings.myOrder.tr,
            ).build(context),
            drawer: const CustomDrawer(
              showMyOrdersB: false,
              showCurrentOrderB: false,
            ),
            body: body,
          );
        },
      ),
    );
  }
}
