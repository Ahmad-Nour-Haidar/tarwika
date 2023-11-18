import '../core/constant/app_constant.dart';
import 'category_model.dart';
import 'item_model.dart';

class MenuDataModel {
  DateTime? dateTime;
  final CategoryModel categoryModel;
  List<ItemModel> itemsData = [];

  int get lastGet {
    final dateNow = DateTime.now();
    if (dateTime == null) {
      dateTime = dateNow;
      return 1000;
    }
    final x = dateNow.difference(dateTime!).inSeconds;
    if (x >= AppConstant.durationTimeGetData) {
      dateTime = dateNow;
    }
    return x;
  }

  MenuDataModel({
    required this.categoryModel,
  });
}
