import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tarwika/core/constant/app_image.dart';
import 'package:tarwika/core/constant/app_local_data.dart';
import 'package:tarwika/core/constant/app_size.dart';
import 'package:tarwika/core/functions/navigator.dart';
import 'package:tarwika/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      pushNamedAndRemoveUntil(_getRoute(), context);
    });
    super.initState();
  }

  String _getRoute() {
    // return AppRoute.language;
    if (AppLocalData.user == null) {
      return AppRoute.language;
    }
    if (AppLocalData.user!.token == null) {
      return AppRoute.language;
    }
    return AppRoute.home;
  }

  @override
  Widget build(BuildContext context) {
    AppSize.initial(context);
    return Image.asset(
      AppImage.hi,
      fit: BoxFit.fill,
      height: double.infinity,
      width: double.infinity,
    );
  }
}
