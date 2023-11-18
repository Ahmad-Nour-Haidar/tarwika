import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarwika/controller/local_controller.dart';
import 'package:tarwika/controller/register_cubit/register_cubit.dart';
import 'package:tarwika/data/remote/auth_data.dart';
import '../../controller/cart_cubit/cart_cubit.dart';
import '../../controller/check_email_cubit/check_email_cubit.dart';
import '../../controller/current_order_details_cubit/current_order_details_cubit.dart';
import '../../controller/favorite_cubit/favorite_cubit.dart';
import '../../controller/favorite_screen_cubit/favorite_screen_cubit.dart';
import '../../controller/item_details_cubit/item_details_cubit.dart';
import '../../controller/login_cubit/login_cubit.dart';
import '../../controller/menu_cubit/menu_cubit.dart';
import '../../controller/my_order_cubit/my_order_cubit.dart';
import '../../controller/order_details_cubit/order_details_cubit.dart';
import '../../controller/profile_cubit/profile_cubit.dart';
import '../../controller/reset_password_cubit/reset_password_cubit.dart';
import '../../controller/verify_code_cubit/verify_code_cubit.dart';
import '../../data/remote/cart_data.dart';
import '../../data/remote/category_data.dart';
import '../../data/remote/favorite_data.dart';
import '../../data/remote/item_data.dart';
import '../../data/remote/order_data.dart';
import '../../my_bloc_observer.dart';
import '../class/crud.dart';

class AppDependency {
  AppDependency._();

  static final getIt = GetIt.instance;

  static Future<void> initial() async {
    // storage
    final sharedPreferences = await SharedPreferences.getInstance();
    getIt.registerLazySingleton(() => sharedPreferences);
    // getIt.registerLazySingletonAsync(() => SharedPreferences.getInstance());

    // start
    getIt.registerLazySingleton(() => LocaleController());
    getIt.registerLazySingleton(() => MyBlocObserver());

    // data
    getIt.registerLazySingleton(() => Crud());
    getIt.registerLazySingleton(() => AuthRemoteData());
    getIt.registerLazySingleton(() => CategoryRemoteData());
    getIt.registerLazySingleton(() => ItemRemoteData());
    getIt.registerLazySingleton(() => FavoriteRemoteData());
    getIt.registerLazySingleton(() => CartRemoteData());
    getIt.registerLazySingleton(() => OrderRemoteData());

    // auth controller
    getIt.registerFactory(() => LoginCubit());
    getIt.registerFactory(() => RegisterCubit());
    getIt.registerFactory(() => VerifyCodeCubit());
    getIt.registerFactory(() => CheckEmailCubit());
    getIt.registerFactory(() => ResetPasswordCubit());
    getIt.registerFactory(() => ProfileCubit());

    // menu controller
    getIt.registerLazySingleton(() => MenuCubit());

    // item controller
    getIt.registerFactory(() => ItemDetailsCubit());

    // favorite controller
    getIt.registerFactory(() => FavoriteCubit());
    getIt.registerFactory(() => FavoriteScreenCubit());

    // order controller
    getIt.registerLazySingleton(() => CurrentOrderDetailsCubit());
    getIt.registerFactory(() => MyOrderCubit());
    getIt.registerFactory(() => OrderDetailsCubit());

    // cart controller
    getIt.registerLazySingleton(() => CartCubit());
  }
}
