import 'package:flutter/cupertino.dart';

void pushNamedAndRemoveUntil(String route, BuildContext context,
    {Object? arguments}) {
  Navigator.pushNamedAndRemoveUntil(
    context,
    route,
    (route) => false, // This will remove all screens
    arguments: arguments,
  );
}

Future<T?> pushNamed<T extends Object?>(String route, BuildContext context,
    {Object? arguments}) {
  return Navigator.pushNamed(context, route, arguments: arguments);
}
