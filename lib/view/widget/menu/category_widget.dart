import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tarwika/view/widget/menu/svg_error_image.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/functions/functions.dart';
import '../../../model/category_model.dart';
import '../../../model/menu_data_model.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.categoryModel,
    required this.onTap,
    required this.isSelected,
  });

  final void Function() onTap;
  final CategoryModel categoryModel;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppSize.radius45),
      onTap: onTap,
      child: Container(
        width: 100,
        height: AppSize.size45,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.buttonColor : AppColor.white,
          border: Border.all(color: AppColor.buttonColor, width: 2),
          borderRadius: BorderRadius.circular(AppSize.radius45),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
              ),
              clipBehavior: Clip.hardEdge,
              child: CachedNetworkImage(
                httpHeaders: const {
                  "Connection": "Keep-Alive",
                  "Keep-Alive": "timeout=5",
                },
                fit: BoxFit.fill,
                imageUrl: getImageCategoryLink(categoryModel.image!),
                errorWidget: (context, url, error) {
                  return const SvgErrorImage(
                    size: 25,
                  );
                },
                placeholder: (context, url) => const Center(
                    child: SizedBox(
                        width: 10,
                        height: 10,
                        child: CircularProgressIndicator(strokeWidth: 3))),
              ),
            ),
            const Gap(5),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  getCategoryName(categoryModel),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({
    super.key,
    required this.onTap,
    required this.menuData,
    required this.selectedCat,
  });

  final void Function(int index) onTap;
  final List<MenuDataModel> menuData;
  final int selectedCat;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.size45,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: menuData.length,
        itemBuilder: (context, index) {
          return CategoryWidget(
            onTap: () {
              onTap(index);
            },
            categoryModel: menuData[index].categoryModel,
            isSelected: selectedCat == index,
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: AppSize.size15);
        },
      ),
    );
  }
}
