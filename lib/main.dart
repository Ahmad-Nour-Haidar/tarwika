import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tarwika/controller/local_controller.dart';
import 'package:tarwika/controller/menu_cubit/menu_cubit.dart';
import 'package:tarwika/routes.dart';
import 'controller/cart_cubit/cart_cubit.dart';
import 'controller/current_order_details_cubit/current_order_details_cubit.dart';
import 'core/functions/functions.dart';
import 'core/localization/translation.dart';
import 'core/resources/theme_manager.dart';
import 'core/services/dependency_injection.dart';
import 'my_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppDependency.initial();
  initialUser();

  Bloc.observer = AppDependency.getIt<MyBlocObserver>();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppDependency.getIt<LocaleController>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => AppDependency.getIt<CurrentOrderDetailsCubit>()),
        BlocProvider(create: (_) => AppDependency.getIt<CartCubit>()),
        BlocProvider(create: (_) => AppDependency.getIt<MenuCubit>()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tarwika',
        locale: controller.locale,
        translations: MyTranslation(),
        theme: themeData(),
        routes: routes,
        initialRoute: AppRoute.splash,
        // home: const DetailsProduct(),
      ),
    );
  }
}
