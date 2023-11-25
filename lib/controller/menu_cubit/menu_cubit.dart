import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarwika/core/constant/app_constant.dart';
import 'package:tarwika/core/constant/app_keys_request.dart';
import 'package:tarwika/core/constant/app_local_data.dart';
import 'package:tarwika/data/remote/item_data.dart';
import '../../core/services/dependency_injection.dart';
import '../../data/remote/category_data.dart';
import '../../data/remote/favorite_data.dart';
import '../../model/category_model.dart';
import '../../model/item_model.dart';
import '../../model/menu_data_model.dart';
import 'menu_state.dart';
import 'package:tarwika/print.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(MenuInitialState());

  static MenuCubit get(BuildContext context) => BlocProvider.of(context);
  final categoryRemoteData = AppDependency.getIt<CategoryRemoteData>();
  final itemRemoteData = AppDependency.getIt<ItemRemoteData>();
  List<MenuDataModel> menuData = [];
  int selectedCat = 0;
  bool isOpenSearch = false;

  Future<void> initial() async {
    printme.green(AppLocalData.user!.token);
    await viewCategory();
    viewItem();
  }

  void openCloseSearch(bool value) {
    isOpenSearch = value;
    if (value) {
      emit(OpenSearchState());
    } else {
      emit(CloseSearchState());
    }
  }

  void refreshItem(ItemModel model) {
    for (final m in menuData) {
      if (m.categoryModel.name == model.categoryName) {
        final ItemModel temp =
            m.itemsData.where((element) => element.id == model.id).first;
        temp.isFavorite = false;
        emit(MenuSuccessItemState());
        break;
      }
    }
  }

  void search(String? value) async {
    if (value == null || value.isEmpty) return;
    emit(LoadingSearchState());
    final token = AppLocalData.user!.token!;
    final response = await itemRemoteData.search(token: token, value: value);
    if (isClosed) return;
    response.fold((l) {
      emit(MenuFailureState(l));
    }, (r) {
      isOpenSearch = false;
      List temp = r[AppRKeys.data];
      final list = List.generate(
          temp.length, (index) => ItemModel.fromJson(temp[index]));
      emit(SuccessSearchState(list, value));
    });
  }

  int get itemsCount => menuData[selectedCat].itemsData.length;

  void changeCat(int index) {
    if (selectedCat == index) {
      return;
    }
    selectedCat = index;
    emit(MenuChangeState());
    viewItem();
  }

  Future<void> onRefresh() async {
    selectedCat = 0;
    await viewCategory();
    viewItem(forceGet: true);
  }

  Future<void> viewCategory() async {
    emit(MenuLoadingCategoryState());
    // emit(MenuLoadingCategoryState());
    final token = AppLocalData.user!.token!;
    final response = await categoryRemoteData.view(data: {}, token: token);
    if (isClosed) return;
    response.fold((l) {
      emit(MenuFailureState(l));
    }, (response) {
      List tempData = response[AppRKeys.data];
      menuData.clear();
      menuData.addAll(tempData
          .map((e) => MenuDataModel(categoryModel: CategoryModel.fromJson(e))));
      emit(MenuSuccessCategoryState());
    });
  }

  void viewItem({bool forceGet = false}) async {
    if (menuData.isEmpty) return;
    final categoryId = menuData[selectedCat].categoryModel.id!;
    final lastGet = menuData[selectedCat].lastGet;
    if (lastGet <= AppConstant.durationTimeGetData) {
      return;
    }
    emit(MenuLoadingItemState());
    final token = AppLocalData.user!.token!;
    final response = await itemRemoteData.view(
      token: token,
      categoryId: categoryId,
    );
    if (isClosed) return;
    response.fold((l) {
      emit(MenuFailureState(l));
    }, (response) {
      List tempData = response[AppRKeys.data];
      final menuDataModelTemp = menuData
          .where((element) => element.categoryModel.id == categoryId)
          .first;
      menuDataModelTemp.itemsData.clear();
      menuDataModelTemp.itemsData
          .addAll(tempData.map((e) => ItemModel.fromJson(e)));
      emit(MenuSuccessItemState());
      return;
    });
  }

  final favoriteRemoteData = AppDependency.getIt<FavoriteRemoteData>();
}
