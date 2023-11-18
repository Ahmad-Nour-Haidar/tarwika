import 'package:flutter/material.dart';
import 'package:tarwika/view/screen/favorite_screen.dart';
import 'package:tarwika/view/screen/profile_screen.dart';
import 'package:tarwika/view/screen/auth/check_email_screen.dart';
import 'package:tarwika/view/screen/auth/login_screen.dart';
import 'package:tarwika/view/screen/auth/register_screen.dart';
import 'package:tarwika/view/screen/auth/reset_password_screen.dart';
import 'package:tarwika/view/screen/auth/type_auth_screen.dart';
import 'package:tarwika/view/screen/auth/verify_code_screen.dart';
import 'package:tarwika/view/screen/cart/cart_screen.dart';
import 'package:tarwika/view/screen/order/date_time_people_screen.dart';
import 'package:tarwika/view/screen/item/item_details_screen.dart';
import 'package:tarwika/view/screen/menu/home_screen.dart';
import 'package:tarwika/view/screen/language_screen.dart';
import 'package:tarwika/view/screen/menu/menu_screen.dart';
import 'package:tarwika/view/screen/order/my_orders_screen.dart';
import 'package:tarwika/view/screen/order/current_order_details_screen.dart';
import 'package:tarwika/view/screen/order/order_details_screen.dart';
import 'package:tarwika/view/screen/splash_screen.dart';

class AppRoute {
  AppRoute._();

  // start
  static const splash = '/splash';
  static const language = '/language';
  static const typeAuth = '/typeAuth';

  // auth
  static const login = '/login';
  static const register = '/register';
  static const verifyCodeScreen = '/verifyCodeScreen';
  static const checkEmail = '/checkEmail';
  static const resetPassword = '/resetPassword';

  // menu
  static const home = '/home';
  static const menu = '/menu';

  // item
  static const itemDetailsScreen = '/itemDetailsScreen';

  // date, time, people
  static const dateTimePeople = '/dateTimePeople';

  // current order details
  static const currentOrderDetails = '/currentOrderDetails';
  static const orderDetails = '/orderDetails';

  // cart
  static const cartScreen = '/cartScreen';

  // my order
  static const myOrdersScreen = '/myOrdersScreen';

  // profile
  static const profileScreen = '/profileScreen';

  // favorite
  static const favoriteScreen = '/favoriteScreen';
}

final Map<String, Widget Function(BuildContext)> routes = {
  // start
  AppRoute.splash: (_) => const SplashScreen(),
  AppRoute.language: (_) => const LanguageScreen(),
  AppRoute.typeAuth: (_) => const TypeAuthScreen(),

  // auth
  AppRoute.register: (_) => const RegisterScreen(),
  AppRoute.login: (_) => const LoginScreen(),
  AppRoute.verifyCodeScreen: (_) => const VerifyCodeScreen(),
  AppRoute.checkEmail: (_) => const CheckEmailScreen(),
  AppRoute.resetPassword: (_) => const ResetPasswordScreen(),

  // menu
  AppRoute.home: (_) => const HomeScreen(),
  AppRoute.menu: (_) => const MenuScreen(),

  // item
  AppRoute.itemDetailsScreen: (_) => const ItemDetailsScreen(),

  // date, time, people
  AppRoute.dateTimePeople: (_) => const DateTimePeopleScreen(),

  // current order details
  AppRoute.currentOrderDetails: (_) => const CurrentOrderDetailsScreen(),
  // order details
  AppRoute.orderDetails: (_) => const OrderDetailsScreen(),

  // cart screen
  AppRoute.cartScreen: (_) => const CartScreen(),
  // my order
  AppRoute.myOrdersScreen: (_) => const MyOrderScreen(),

  // profile
  AppRoute.profileScreen: (_) => const ProfileScreen(),

  // favorite
  AppRoute.favoriteScreen: (_) => const FavoriteScreen(),
};
