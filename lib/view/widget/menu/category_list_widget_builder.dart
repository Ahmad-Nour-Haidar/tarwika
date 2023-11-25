import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarwika/core/functions/functions.dart';
import 'package:tarwika/core/resources/app_text_theme.dart';
import '../../../controller/menu_cubit/menu_cubit.dart';
import '../../../controller/menu_cubit/menu_state.dart';
import 'category_widget.dart';
import '../custom_loading_widget/loading_category.dart';

class CategoryListWidgetBuilder extends StatelessWidget {
  const CategoryListWidgetBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCubit, MenuState>(
      buildWhen: (previous, current) {
        // return true;
        if (current is MenuLoadingCategoryState) return true;
        if (current is MenuSuccessCategoryState) return true;
        if (current is MenuChangeState) return true;
        if (current is CloseSearchState) return true;
        return false;
      },
      builder: (context, state) {
        final cubit = MenuCubit.get(context);
        if (state is MenuLoadingCategoryState) {
          return const LoadingCategory();
        }
        if (state is MenuSuccessCategoryState ||
            state is MenuChangeState ||
            state is CloseSearchState) {
          return SizedBox(
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CategoryListWidget(
                  selectedCat: cubit.selectedCat,
                  menuData: cubit.menuData,
                  onTap: (index) {
                    cubit.changeCat(index);
                  },
                ),
                const SizedBox(height: 5),
                if (cubit.menuData.isNotEmpty)
                  Expanded(
                    child: FittedBox(
                      child: Text(
                        getCategoryName(
                          cubit.menuData[cubit.selectedCat].categoryModel,
                        ),
                        style: AppTextTheme.f32w600black,
                      ),
                    ),
                  ),
                const SizedBox(height: 5),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
