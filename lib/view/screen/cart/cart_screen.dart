import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tarwika/core/constant/app_color.dart';
import 'package:tarwika/core/constant/app_lottie.dart';
import 'package:tarwika/core/constant/app_size.dart';
import 'package:tarwika/core/constant/app_strings.dart';
import 'package:tarwika/core/resources/app_text_theme.dart';
import 'package:tarwika/view/widget/custom_app_bar.dart';
import 'package:tarwika/view/widget/custom_drawer.dart';
import 'package:tarwika/view/widget/handle_state.dart';
import '../../../controller/cart_cubit/cart_cubit.dart';
import '../../../controller/cart_cubit/cart_state.dart';
import '../../widget/cart_widget.dart';
import '../../widget/custom_loading_widget/loading_cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final cubit = CartCubit.get(context);
    cubit.initial();
    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(
        key: scaffoldKey,
        title: AppStrings.mealsOrdered.tr,
      ).build(context),
      drawer: const CustomDrawer(showCurrentOrderB: false),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartFailureState) {
            handleState(context: context, state: state.state);
          }
        },
        builder: (context, state) {
          // final cubit = CartCubit.get(context);
          if (state is CartLoadingState) {
            return LoadingCartItem(onRefresh: cubit.onRefresh);
          }
          if (state is CartFailureState) {
            return LottieBuilder.asset(AppLottie.oops);
          }
          if (cubit.dataModel.isEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LottieBuilder.asset(AppLottie.listEmpty),
                const SizedBox(height: 30),
                SizedBox(
                  width: AppSize.width * .75,
                  child: Text(
                    textAlign: TextAlign.center,
                    AppStrings.youHaveNoOrderedMealsYet.tr,
                    style: AppTextTheme.f18w500black,
                  ),
                ),
              ],
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              cubit.viewData();
            },
            child: Padding(
              padding: const EdgeInsets.all(AppSize.screenPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: cubit.dataModel.length,
                      itemBuilder: (context, index) => CartWidget(
                        model: cubit.dataModel[index],
                        onTapDelete: () => cubit.delete(cubit.dataModel[index]),
                      ),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 20),
                    ),
                  ),
                  const SizedBox(height: AppSize.size10),
                  Text(
                    '${AppStrings.meal.tr} (${cubit.totalCount})',
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColor.gray2,
                    ),
                  ),
                  const SizedBox(height: AppSize.size10),
                  Text(
                    '${AppStrings.totalPrice.tr}: ${cubit.totalPrice} S.P',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      color: AppColor.black,
                    ),
                  ),
                  const SizedBox(height: AppSize.size10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
