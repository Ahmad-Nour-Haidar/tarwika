import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/constant/app_strings.dart';
import '../../../core/constant/app_svg.dart';
import '../../../core/functions/functions.dart';
import '../../../core/resources/app_text_theme.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({
    super.key,
    required this.onFieldSubmitted,
    required this.changeOpen,
    required this.needFocus,
    required this.isOpen,
  });

  final void Function(String? value) onFieldSubmitted;
  final void Function(bool value) changeOpen;
  final bool needFocus;
  final bool isOpen;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  late bool currentOpen;

  @override
  void initState() {
    initial();
    super.initState();
  }

  void initial() {
    currentOpen = widget.isOpen;
    if (widget.needFocus) {
      _focusNode.requestFocus();
    }
  }

  @override
  void didUpdateWidget(covariant SearchWidget oldWidget) {
    initial();
    super.didUpdateWidget(oldWidget);
  }

  String get icon {
    final s = !currentOpen
        ? AppSvg.search
        : isEnglish()
            ? AppSvg.arrowLeft
            : AppSvg.arrowRight;
    return s;
  }

  void onTap(bool value) {
    if (value == currentOpen) return;
    currentOpen = value;
    widget.changeOpen(currentOpen);
    if (value) {
      _focusNode.requestFocus();
    } else {
      _controller.clear();
      _focusNode.unfocus();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.screenPadding),
      child: SizedBox(
        height: 50,
        child: TextFormField(
          controller: _controller,
          focusNode: _focusNode,
          onTap: () => onTap(true),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textDirection: getTextDirection(_controller.text),
          onFieldSubmitted: (value) {
            widget.onFieldSubmitted(value);
          },
          textInputAction: TextInputAction.search,
          keyboardType: TextInputType.text,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            prefixIcon: InkWell(
              onTap: () => currentOpen ? onTap(false) : null,
              borderRadius: BorderRadius.circular(AppSize.radius45),
              child: Padding(
                padding: EdgeInsets.all(currentOpen ? 6 : 12),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: SvgPicture.asset(
                    icon,
                    width: currentOpen ? 30 : 20,
                    height: currentOpen ? 30 : 20,
                    colorFilter: const ColorFilter.mode(
                      AppColor.white,
                      BlendMode.srcATop,
                    ),
                  ),
                ),
              ),
            ),
            suffixIcon: currentOpen && _controller.text.isNotEmpty
                ? InkWell(
                    onTap: () {
                      setState(() {
                        _controller.clear();
                      });
                    },
                    borderRadius: BorderRadius.circular(AppSize.radius45),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: SvgPicture.asset(
                          AppSvg.close,
                          width: 25,
                          height: 25,
                          colorFilter: const ColorFilter.mode(
                            AppColor.white,
                            BlendMode.srcATop,
                          ),
                        ),
                      ),
                    ),
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            hintTextDirection: getTextDirectionOnLang(),
            hintStyle: AppTextTheme.hintStyle,
            hintText: AppStrings.findFood.tr,
            fillColor: AppColor.primaryColor,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSize.radius45),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
