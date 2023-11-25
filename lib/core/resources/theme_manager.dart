import 'package:flutter/material.dart';
import 'package:tarwika/generate_material_color.dart';

import '../constant/app_color.dart';

ThemeData themeData() => ThemeData(
      applyElevationOverlayColor: false,
      appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0,
      ),
      fontFamily: 'Inter',
      useMaterial3: true,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: generateMaterialColor(color: AppColor.buttonColor),
        backgroundColor: AppColor.white,
      ),
    );
