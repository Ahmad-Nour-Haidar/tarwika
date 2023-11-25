import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tarwika/core/constant/app_size.dart';
import 'package:tarwika/core/constant/app_strings.dart';
import 'package:tarwika/core/services/dependency_injection.dart';
import 'package:tarwika/view/widget/menu/item_widget.dart';
import '../../controller/favorite_screen_cubit/favorite_screen_cubit.dart';
import '../../controller/favorite_screen_cubit/favorite_screen_state.dart';
import '../../core/constant/app_lottie.dart';
import '../widget/custom_app_bar.dart';
import '../widget/custom_drawer.dart';
import '../widget/custom_loading_widget/loading_item.dart';
import '../widget/empty_widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocProvider(
      create: (context) =>
          AppDependency.getIt<FavoriteScreenCubit>()..initial(),
      child: BlocConsumer<FavoriteScreenCubit, FavoriteScreenState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = FavoriteScreenCubit.get(context);
          Widget? body;
          if (state is FavoriteScreenSuccessState && cubit.data.isNotEmpty) {
            body = Column(
              children: <Widget>[
                const SizedBox(height: AppSize.size10),
                ItemListWidget(
                  items: cubit.data,
                  onRefresh: cubit.view,
                  onTapFav: (model) {
                    cubit.onTapFav(model, context);
                  },
                ),
              ],
            );
          }
          if (state is FavoriteScreenSuccessState && cubit.data.isEmpty) {
            body = EmptyWidget(
              text: AppStrings.youHaveNoFoodsFavoriteYet.tr,
              lottie: AppLottie.addFav,
            );
          }
          body ??= Column(
            children: [
              LoadingItem(onRefresh: cubit.view),
            ],
          );
          return Scaffold(
            key: scaffoldKey,
            drawer: const CustomDrawer(
              showCurrentOrderB: false,
              showMyOrdersB: false,
              showFavB: false,
            ),
            appBar: CustomAppBar(
              title: AppStrings.favorite.tr,
              key: scaffoldKey,
            ).build(context),
            body: Padding(
              padding: const EdgeInsets.all(AppSize.screenPadding),
              child: body,
            ),
          );
        },
      ),
    );
  }
}
