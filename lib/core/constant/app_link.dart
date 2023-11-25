class AppLink {
  AppLink._();

  // static const _host = '10.0.2.2:8000';

  // static const _host = 'localhost:8000';
  //
  static const _host = '192.168.43.198:8000';
  //
  // static const _host = '192.168.229.48:8000';

  // static const _host = '192.168.108.48:8000';

  static const _serverApi = 'http://$_host/api';

  static const _serverUpload = 'http://$_host';

  static const _serverImage = '$_serverUpload/images';

  // http://10.0.2.2:8000/images/items/image.png
  // http://127.0.0.1/images/users/image.png
  // http://127.0.0.1/images/categories/image.png

  // auth
  // http://10.0.2.2:8000/api/auth/register
  static const register = '$_serverApi/auth/register';

  static const login = '$_serverApi/auth/login';
  static const verifyCode = '$_serverApi/auth/verify-code';
  static const checkEmail = '$_serverApi/auth/check-email';
  static const resetPassword = '$_serverApi/auth/reset-password';
  static const profile = '$_serverApi/auth/profile';
  static const logout = '$_serverApi/auth/logout';
  static const edit = '$_serverApi/auth/edit';
  static const userImage = '$_serverImage/users';

  // category
  static const categoryView = '$_serverApi/category/view';
  static const categoryImage = '$_serverImage/categories';

  // item
  static const itemView = '$_serverApi/item/view';
  static const itemSearch = '$_serverApi/item/search';
  static const itemImage = '$_serverImage/items';

  // favorite
  static const favoriteView = '$_serverApi/favorite/view';
  static const favoriteAdd = '$_serverApi/favorite/add';
  static const favoriteDelete = '$_serverApi/favorite/delete';

  // cart
  static const cartView = '$_serverApi/cart/view';
  static const cartCountItems = '$_serverApi/cart/countItems';
  static const cartStore = '$_serverApi/cart/store';
  static const cartGetDetailsItem = '$_serverApi/cart/get-details-item';
  static const cartDelete = '$_serverApi/cart/delete';

  // order
  static const orderView = '$_serverApi/order/view';
  static const orderOrder = '$_serverApi/order/order';
  static const orderDetails = '$_serverApi/order/details';
}
