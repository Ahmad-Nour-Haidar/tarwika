import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controller/menu_cubit/menu_cubit.dart';
import '../../../controller/menu_cubit/menu_state.dart';
import 'item_widget.dart';
import '../custom_loading_widget/loading_item.dart';

class ItemListWidgetBuilder extends StatelessWidget {
  const ItemListWidgetBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCubit, MenuState>(
      buildWhen: (previous, current) {
        return true;
        // if (current is MenuLoadingItemState) return true;
        // if (current is MenuLoadingCategoryState) return true;
        // if (current is MenuSuccessItemState) return true;
        // if (current is MenuChangeState) return true;
        // if (current is MenuCloseSearchState) return true;
        // return false;
      },
      builder: (context, state) {
        final cubit = MenuCubit.get(context);
        if (state is MenuLoadingItemState ||
            state is MenuLoadingCategoryState) {
          return LoadingItem(
            onRefresh: cubit.onRefresh,
          );
        }
        if ((state is MenuSuccessItemState ||
                state is MenuChangeState ||
                state is CloseSearchState) &&
            cubit.menuData.isNotEmpty) {
          return ItemListWidget(
            items: cubit.menuData[cubit.selectedCat].itemsData,
            onRefresh: cubit.onRefresh,
          );
        }
        return const SizedBox();
      },
    );
  }
}
