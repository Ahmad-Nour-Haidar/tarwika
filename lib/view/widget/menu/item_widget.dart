import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarwika/controller/favorite_cubit/favorite_cubit.dart';
import 'package:tarwika/controller/favorite_cubit/favorite_state.dart';
import 'package:tarwika/core/functions/navigator.dart';
import 'package:tarwika/core/services/dependency_injection.dart';
import 'package:tarwika/model/screen_arguments.dart';
import 'package:tarwika/routes.dart';
import 'package:tarwika/view/widget/handle_state.dart';
import 'package:tarwika/view/widget/menu/svg_error_image.dart';
import '../../../app_icon_icons.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_keys.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/functions/functions.dart';
import '../../../model/item_model.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.itemModel,
    this.onTapFav,
  });

  final ItemModel itemModel;
  final void Function(ItemModel model)? onTapFav;

  double get width => ((AppSize.width - 50) / 2);

  double get height => width + 50;

  @override
  Widget build(BuildContext context) {
    final tag = UniqueKey();
    return InkWell(
      onTap: () {
        pushNamed(AppRoute.itemDetailsScreen, context,
            arguments: ScreenArguments({
              AppKeys.itemModel: itemModel,
              AppKeys.tag: tag,
            }));
      },
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(0),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: AppColor.cardColor,
            borderRadius: BorderRadius.circular(AppSize.radius10)),
        child: Column(
          children: [
            Expanded(
              child: Hero(
                // tag: itemModel.id!,
                tag: tag,
                child: ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(2),
                    bottomRight: Radius.circular(2),
                  ),
                  child: CachedNetworkImage(
                    httpHeaders: const {
                      "Connection": "Keep-Alive",
                      "Keep-Alive": "timeout=5",
                    },
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    fit: BoxFit.fill,
                    imageUrl: getImageItemLink(itemModel.image!),
                    errorWidget: (context, url, error) {
                      return const SvgErrorImage(size: 75);
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  const SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      getItemName(itemModel),
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  BlocProvider(
                    create: (_) => AppDependency.getIt<FavoriteCubit>(),
                    child: BlocConsumer<FavoriteCubit, FavoriteState>(
                      listener: (context, state) {
                        if (state is FavoriteFailureState) {
                          handleState(context: context, state: state.state);
                        }
                      },
                      builder: (context, state) {
                        final cubit = FavoriteCubit.get(context);
                        return IconButton(
                          tooltip: 'favorite',
                          onPressed: () {
                            if (onTapFav != null) {
                              onTapFav!(itemModel);
                            } else {
                              cubit.onTapFav(itemModel);
                            }
                          },
                          icon: Icon(
                            itemModel.isFavorite!
                                ? AppIcon.favorite
                                : AppIcon.favorite_border,
                            size: 16,
                            color: AppColor.buttonColor,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ItemListWidget extends StatelessWidget {
  const ItemListWidget({
    super.key,
    required this.items,
    required this.onRefresh,
    this.onTapFav,
  });

  final List<ItemModel> items;
  final void Function(ItemModel model)? onTapFav;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView(
          children: [
            Wrap(
              spacing: 20,
              runSpacing: 10,
              children: List.generate(
                items.length,
                (index) => ItemWidget(
                  onTapFav: onTapFav,
                  itemModel: items[index],
                ),
              ),
            ),
            const SizedBox(height: 75),
          ],
        ),
      ),
    );
  }
}
