import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tarwika/controller/menu_cubit/menu_cubit.dart';
import 'package:tarwika/controller/menu_cubit/menu_state.dart';
import 'package:tarwika/core/constant/app_lottie.dart';
import 'package:tarwika/core/constant/app_size.dart';
import 'package:tarwika/core/constant/app_strings.dart';
import 'package:tarwika/core/functions/navigator.dart';
import 'package:tarwika/core/resources/app_text_theme.dart';
import 'package:tarwika/routes.dart';
import 'package:tarwika/view/widget/custom_loading_widget/loading_item.dart';
import 'package:tarwika/view/widget/handle_state.dart';
import '../../../core/constant/app_svg.dart';
import '../../widget/back_button_wrapper.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_drawer.dart';
import '../../widget/menu/category_list_widget_builder.dart';
import '../../widget/menu/item_list_widget_builder.dart';
import '../../widget/menu/item_widget.dart';
import '../../widget/menu/search_widget.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final cubit = MenuCubit.get(context)..initial();
    return BlocConsumer<MenuCubit, MenuState>(
      listener: (context, state) {
        if (state is MenuFailureState) {
          handleState(context: context, state: state.state);
        }
      },
      builder: (context, state) {
        Widget? body;
        if (state is LoadingSearchState) {
          body = Column(
            children: [
              const Gap(20),
              LoadingItem(onRefresh: () async {}),
            ],
          );
        }
        if (state is OpenSearchState) {
          body = const SizedBox();
        }
        if (state is SuccessSearchState && state.data.isEmpty) {
          final s = '${AppStrings.resultsSearchFor.tr} : ${state.value}';
          body = Padding(
            padding: const EdgeInsets.all(AppSize.screenPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(child: Text(s, style: AppTextTheme.f18w500black)),
                const Gap(10),
                Center(child: Lottie.asset(AppLottie.noDataAfterSearch)),
              ],
            ),
          );
        }
        if (state is SuccessSearchState && state.data.isNotEmpty) {
          final s = '${AppStrings.resultsSearchFor.tr} : ${state.value}';
          body = Padding(
            padding: const EdgeInsets.all(AppSize.screenPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(child: Text(s, style: AppTextTheme.f18w500black)),
                const Gap(10),
                ItemListWidget(
                  items: state.data,
                  onRefresh: () async {},
                ),
              ],
            ),
          );
        }
        body ??= const Padding(
          padding: EdgeInsets.only(
            left: AppSize.screenPadding,
            right: AppSize.screenPadding,
            top: 0,
            bottom: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppSize.size10),
              CategoryListWidgetBuilder(),
              ItemListWidgetBuilder(),
            ],
          ),
        );
        return BackButtonWrapper(
          child: Scaffold(
            key: scaffoldKey,
            drawer: const CustomDrawer(showMenuB: false),
            appBar: CustomAppBar(
              showArrowBack: false,
              key: scaffoldKey,
            ).build(context),
            floatingActionButton: (state is SearchState &&
                    state is! CloseSearchState)
                ? null
                : FloatingActionButton(
                    onPressed: () {
                      pushNamed(AppRoute.currentOrderDetails, context);
                    },
                    elevation: 2,
                    child:
                        SvgPicture.asset(AppSvg.order, width: 32, height: 32),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverList.list(
                    children: [
                      if (!cubit.isOpenSearch)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSize.screenPadding),
                          child: Text(
                            AppStrings.readyToOrderYourFavoriteFood.tr,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                      const SizedBox(height: AppSize.size10),
                      SearchWidget(
                        changeOpen: cubit.openCloseSearch,
                        onFieldSubmitted: cubit.search,
                        needFocus: state is OpenSearchState,
                        isOpen: (state is SearchState &&
                            state is! CloseSearchState),
                      ),
                    ],
                  ),
                ];
              },
              body: body,
            ),
          ),
        );
      },
    );
  }
}
