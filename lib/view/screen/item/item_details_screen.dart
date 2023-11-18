import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tarwika/controller/cart_cubit/cart_cubit.dart';
import 'package:tarwika/core/constant/app_color.dart';
import 'package:tarwika/core/constant/app_size.dart';
import 'package:tarwika/core/constant/app_strings.dart';
import 'package:tarwika/core/services/dependency_injection.dart';
import 'package:tarwika/model/item_model.dart';
import 'package:tarwika/view/widget/item_details/row_text_span.dart';
import 'package:tarwika/view/widget/custom_button.dart';
import 'package:tarwika/view/widget/handle_state.dart';
import '../../../controller/item_details_cubit/item_details_cubit.dart';
import '../../../controller/item_details_cubit/item_details_state.dart';
import '../../../core/constant/app_keys.dart';
import '../../../core/functions/functions.dart';
import '../../../model/screen_arguments.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_drawer.dart';
import '../../widget/item_details/counter_widget.dart';
import '../../widget/item_details/size_widget.dart';
import '../../widget/menu/svg_error_image.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({super.key});

  CrossAxisAlignment get crossAxisAlignment =>
      isEnglish() ? CrossAxisAlignment.center : CrossAxisAlignment.end;

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocProvider(
      create: (_) => AppDependency.getIt<ItemDetailsCubit>()..initial(context),
      child: BlocConsumer<ItemDetailsCubit, ItemDetailsState>(
        listener: (context, state) {
          handleState(context: context, state: state.state);
          if (state is ItemDetailsStoreSuccessState) {
            CartCubit.get(context).initial();
          }
        },
        builder: (context, state) {
          final cubit = ItemDetailsCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            backgroundColor: AppColor.primaryColor,
            appBar: CustomAppBar(
              key: scaffoldKey,
            ).build(context),
            drawer: const CustomDrawer(
              showFavB: false,
            ),
            body: SingleChildScrollView(
              child: Stack(
                fit: StackFit.passthrough,
                children: [
                  SizedBox(
                    height: AppSize.radius,
                    width: AppSize.width,
                    child: const DecoratedBox(
                        decoration: BoxDecoration(color: AppColor.white)),
                  ),
                  Container(
                    padding: const EdgeInsets.all(AppSize.screenPadding),
                    margin: EdgeInsets.only(top: AppSize.radius),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: AppSize.radius),
                        Row(
                          children: [
                            RowTextSpan(
                              s1: '${AppStrings.name.tr} : ',
                              s2: getItemName(cubit.itemModel),
                            ),
                          ],
                        ),
                        if (cubit.count != null) const SizedBox(height: 20),
                        if (cubit.count != null)
                          Row(
                            crossAxisAlignment: crossAxisAlignment,
                            children: [
                              RowTextSpan(
                                s1: '${AppStrings.price.tr} : ',
                                s2: '${cubit.price} S.P',
                              ),
                              CounterWidget(
                                onTapMinus: () => cubit.changeCount(-1),
                                onTapPlus: () => cubit.changeCount(1),
                                text: cubit.count.toString(),
                              ),
                            ],
                          ),
                        if (cubit.count != null) const SizedBox(height: 20),
                        if (cubit.count != null)
                          Row(
                            crossAxisAlignment: crossAxisAlignment,
                            children: [
                              RowTextSpan(
                                s1: '${AppStrings.totalPrice.tr} : ',
                                s2: '${cubit.totalPrice} S.P',
                              ),
                            ],
                          ),
                        const SizedBox(height: 20),
                        Text(AppStrings.aboutTheFood.tr, style: textStyle1()),
                        const SizedBox(height: 10),
                        Text(getItemDescription(cubit.itemModel),
                            style: textStyle2()),
                        const SizedBox(height: 20),
                        if (cubit.size != null && cubit.hasMultiSize)
                          SizeWidget(
                            currentSize: cubit.size!,
                            onChange: cubit.changeSize,
                          ),
                        const SizedBox(height: 30),
                        if (state is ItemDetailsLoadingState)
                          const SpinKitThreeBounce(color: AppColor.white),
                        if (state is! ItemDetailsLoadingState &&
                            cubit.count != null)
                          Center(
                            child: CustomButton(
                              text: AppStrings.addToCart.tr,
                              onTap: cubit.store,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                              color: AppColor.white,
                              height: AppSize.size40,
                              radius: AppSize.radius35,
                              width: AppSize.width / 2,
                              elevation: 0,
                            ),
                          ),
                        if (state is ItemDetailsLoadingDataState)
                          const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: SpinKitFoldingCube(color: AppColor.white),
                          ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                  ItemImage(itemModel: cubit.itemModel),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ItemImage extends StatelessWidget {
  const ItemImage({
    super.key,
    required this.itemModel,
  });

  final ItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    final tag = args.args[AppKeys.tag];
    return Hero(
      tag: tag,
      child: Align(
        alignment: Alignment.topCenter,
        child: CircleAvatar(
          radius: AppSize.radius,
          backgroundColor: AppColor.white,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSize.radiusImage),
            clipBehavior: Clip.hardEdge,
            child: CachedNetworkImage(
              httpHeaders: const {
                "Connection": "Keep-Alive",
                "Keep-Alive": "timeout=5",
              },
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              width: AppSize.widthHeight,
              height: AppSize.widthHeight,
              // fit: BoxFit.fitWidth,
              imageUrl: getImageItemLink(itemModel.image!),
              errorWidget: (context, url, error) {
                return const SvgErrorImage(size: 75);
              },
            ),
          ),
        ),
      ),
    );
  }
}
