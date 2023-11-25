import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tarwika/controller/order_details_cubit/order_details_state.dart';
import 'package:tarwika/core/services/dependency_injection.dart';
import 'package:tarwika/view/widget/handle_state.dart';
import '../../../controller/order_details_cubit/order_details_cubit.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/constant/app_strings.dart';
import '../../../model/order_details_model.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_drawer.dart';
import '../../widget/custom_loading_widget/loading_order_details.dart';
import '../../widget/item_details/row_text_span.dart';
import '../../widget/order_info/custom_order_details_widget.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocProvider(
      create: (_) => AppDependency.getIt<OrderDetailsCubit>()..initial(context),
      child: BlocConsumer<OrderDetailsCubit, OrderDetailsState>(
        listener: (context, state) {
          if (state is OrderDetailsFailureState) {
            handleState(context: context, state: state.state);
          }
        },
        builder: (context, state) {
          final cubit = OrderDetailsCubit.get(context);
          Widget? body;
          if (state is OrderDetailsSuccessState) {
            body = OrderDetailsList(data: cubit.data);
          } else {
            body = const LoadingOrderDetails();
          }
          return Scaffold(
            key: scaffoldKey,
            backgroundColor: AppColor.primaryColor,
            appBar: CustomAppBar(
              key: scaffoldKey,
              title: AppStrings.orderDetails.tr,
              backgroundColor: AppColor.primaryColor,
            ).build(context),
            drawer: const CustomDrawer(
              showCurrentOrderB: false,
              showMyOrdersB: false,
            ),
            body: FadeInUp(
              from: 200,
              duration: const Duration(milliseconds: 500),
              child: Container(
                padding: const EdgeInsets.only(
                  bottom: AppSize.screenPadding,
                  left: AppSize.screenPadding,
                  right: AppSize.screenPadding,
                  top: 50,
                ),
                decoration: const BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppSize.radius65),
                    topRight: Radius.circular(AppSize.radius65),
                  ),
                ),
                child: body,
              ),
            ),
          );
        },
      ),
    );
  }
}

class OrderDetailsList extends StatelessWidget {
  const OrderDetailsList({
    super.key,
    required this.data,
  });

  final List<OrderDetailsModel> data;

  @override
  Widget build(BuildContext context) {
    final cubit = OrderDetailsCubit.get(context);
    return ListView(
      children: [
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: cubit.textList.length,
          separatorBuilder: (context, index) =>
              const SizedBox(height: AppSize.size10),
          itemBuilder: (context, index) => Row(
            children: [
              RowTextSpan(
                s1: cubit.textList[index]['s1'].toString(),
                s2: cubit.textList[index]['s2'].toString(),
              ),
            ],
          ),
        ),
        ...List.generate(
          data.length,
          (index) => CustomOrderDetailsWidget(
            model: data[index],
            index: index,
          ),
        )
      ],
    );
  }
}
