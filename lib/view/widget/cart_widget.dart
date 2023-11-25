import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_icon_icons.dart';
import '../../core/constant/app_color.dart';
import '../../core/constant/app_constant.dart';
import '../../core/constant/app_keys.dart';
import '../../core/constant/app_size.dart';
import '../../core/constant/app_strings.dart';
import '../../core/functions/functions.dart';
import '../../core/functions/navigator.dart';
import '../../model/cart_model.dart';
import '../../model/item_model.dart';
import '../../model/screen_arguments.dart';
import '../../routes.dart';
import 'menu/svg_error_image.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({
    super.key,
    required this.model,
    required this.onTapDelete,
  });

  final CartModel model;
  final void Function() onTapDelete;

  @override
  Widget build(BuildContext context) {
    final tag = UniqueKey();
    return InkWell(
      onTap: () {
        pushNamed(AppRoute.itemDetailsScreen, context,
            arguments: ScreenArguments({
              AppKeys.itemModel: ItemModel.fromCartModel(model),
              AppKeys.tag: tag,
            }));
      },
      child: Material(
        elevation: AppSize.elevation4,
        color: AppColor.cardColor,
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(AppSize.radius10),
        child: Container(
          padding: const EdgeInsets.all(AppSize.padding10),
          child: Row(
            children: [
              Hero(
                tag: tag,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppSize.radius35),
                  clipBehavior: Clip.hardEdge,
                  child: CachedNetworkImage(
                    httpHeaders: const {
                      "Connection": "Keep-Alive",
                      "Keep-Alive": "timeout=5",
                    },
                    width: 70,
                    height: 70,
                    fit: BoxFit.fitWidth,
                    imageUrl: getImageItemLink(model.image!),
                    errorWidget: (context, url, error) {
                      return const SvgErrorImage(size: 75);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: isEnglish()
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                maxLines: 2,
                                getCartName(model),
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // const Spacer(),
                        const SizedBox(width: 30),
                        if (model.categoryName == AppConstant.pizza)
                          Text(
                            '( ${model.size!.tr} )',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '${AppStrings.meal.tr}: ${model.count!}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '${AppStrings.totalPrice.tr}: ${model.totalPrice!}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: onTapDelete,
                          child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              AppIcon.trash,
                              size: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
