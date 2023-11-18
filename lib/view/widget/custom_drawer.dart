import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarwika/core/constant/app_color.dart';
import 'package:tarwika/core/constant/app_size.dart';
import 'package:tarwika/core/constant/app_strings.dart';
import 'package:tarwika/core/constant/app_svg.dart';
import 'package:tarwika/core/functions/navigator.dart';
import 'package:tarwika/core/services/dependency_injection.dart';
import 'package:tarwika/routes.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    this.showHomeB = true,
    this.showProfileB = true,
    this.showMenuB = true,
    this.showCurrentOrderB = true,
    this.showMyOrdersB = true,
    this.showFavB = true,
    this.showLogoutB = false,
    this.buildContext,
  });

  final bool showHomeB;
  final bool showProfileB;
  final bool showMenuB;
  final bool showCurrentOrderB;
  final bool showMyOrdersB;
  final bool showFavB;
  final bool showLogoutB;
  final BuildContext? buildContext;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(AppSize.screenPadding),
        // width: AppSize.width * .5,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (showHomeB)
              DrawerWidget(
                onTap: () {
                  // Navigator.pop(context);
                  pushNamedAndRemoveUntil(AppRoute.home, context);
                },
                text: AppStrings.home.tr,
                image: AppSvg.home,
              ),
            if (showMenuB)
              DrawerWidget(
                onTap: () {
                  // Navigator.pop(context);
                  pushNamedAndRemoveUntil(AppRoute.menu, context);
                },
                text: AppStrings.menu.tr,
                image: AppSvg.menu,
              ),
            if (showCurrentOrderB)
              DrawerWidget(
                onTap: () {
                  Navigator.pop(context);
                  pushNamed(AppRoute.currentOrderDetails, context);
                },
                text: AppStrings.currentOrder.tr,
                image: AppSvg.currentOrder,
              ),
            if (showMyOrdersB)
              DrawerWidget(
                onTap: () {
                  Navigator.pop(context);
                  pushNamed(AppRoute.myOrdersScreen, context);
                },
                text: AppStrings.myOrders.tr,
                image: AppSvg.orders,
              ),
            if (showFavB)
              DrawerWidget(
                onTap: () {
                  Navigator.pop(context);
                  pushNamed(AppRoute.favoriteScreen, context);
                },
                text: AppStrings.favorite.tr,
                image: AppSvg.heart,
              ),
            if (showProfileB)
              DrawerWidget(
                onTap: () {
                  Navigator.pop(context);
                  pushNamed(AppRoute.profileScreen, context);
                },
                text: AppStrings.profile.tr,
                image: AppSvg.profile,
              ),
            if (showLogoutB && buildContext != null)
              DrawerWidget(
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                      context: buildContext!,
                      builder: (_) {
                        return AlertDialog(
                          // backgroundColor: AppColor.snackbarColor,
                          // titleTextStyle: AppTextTheme.f24w600black,
                          title: Text(AppStrings.logOut.tr),
                          content: Text(AppStrings.doYouWantToLogOut.tr),
                          actions: [
                            TextButton(
                              onPressed: () {},
                              child: Text(AppStrings.no.tr),
                            ),
                            TextButton(
                              onPressed: () {
                                final s =
                                    AppDependency.getIt<SharedPreferences>();
                                s.clear();
                                pushNamedAndRemoveUntil(
                                  AppRoute.register,
                                  buildContext!,
                                );
                              },
                              child: Text(AppStrings.yes.tr),
                            ),
                          ],
                        );
                      });
                },
                text: AppStrings.logOut.tr,
                image: AppSvg.logOut,
              ),
          ],
        ),
      ),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
    required this.onTap,
    required this.text,
    required this.image,
  });

  final void Function() onTap;
  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              image,
              width: 22,
              height: 22,
              colorFilter: const ColorFilter.mode(
                AppColor.primaryColor,
                BlendMode.srcIn,
              ),
            ),
            const Gap(16),
            Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
