import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../constant/styles.dart';
import '../../utils/core/extensions/extensions_export.dart';
import '../common/svg_icon.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color backgroundColor;
  final List<Color> colors;
  final bool? isLoading;
  final Color textColor;
  final Color? borderColor;
  final String? icondData;
  final double borderRadius;
  final double borderwidth;
  final bool small;
  final FontWeight fontWeight;
  final Widget? icon;
  final double? width;

  const SubmitButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.colors = const [],
    this.backgroundColor = Colors.white,
    this.textColor = Colors.white,
    this.borderColor,
    this.isLoading,
    this.icondData,
    this.small = false,
    this.borderRadius = 10,
    this.borderwidth = 1.2,
    this.fontWeight = FontWeight.normal,
    this.width,
  }) : icon = null;

  const SubmitButton.icon({
    super.key,
    required this.onPressed,
    required this.icon,
    this.colors = const [],
    this.backgroundColor = Colors.white,
    this.textColor = Colors.white,
    this.borderColor,
    this.isLoading,
    this.icondData,
    this.small = false,
    this.borderRadius = 10,
    this.borderwidth = 1.2,
    this.fontWeight = FontWeight.normal,
    this.width,
  }) : title = '';

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
        onTap: () {
          if (isLoading != null && isLoading!) {
            return;
          }
          onPressed();
        },
        child: Ink(
          height: 53.0,
          width: double.infinity,
          decoration: BoxDecoration(
            border: borderColor == null
                ? null
                : Border.all(
                    color: borderColor!,
                    width: borderwidth,
                  ),
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
            color: colors.isNotEmpty ? null : backgroundColor,
            gradient: colors.isEmpty ? null : LinearGradient(colors: colors),
            boxShadow: colors.isEmpty
                ? null
                : [
                    BoxShadow(
                      offset: const Offset(0, 5),
                      spreadRadius: -2,
                      blurRadius: 10,
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withValues(alpha: .5),
                    ),
                  ],
          ),
          child: isLoading != null && isLoading!
              ? Center(
                  child: SizedBox(
                    height: 20.0,
                    width: 20.0,
                    child: CircularProgressIndicator(color: textColor),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icondData != null)
                      SvgIcon(
                        icondData!,
                        color: textColor,
                        size: 22.0,
                      )
                    else
                      const SizedBox.shrink(),
                    Gap($styles.insets.xs).visibleWhen(icondData != null),
                    if (icon != null)
                      icon!
                    else
                      AutoSizeText(
                        title,
                        maxLines: 1,
                        minFontSize: 8,
                        style: TextStyle(
                          fontWeight: fontWeight,
                          fontSize: 15.0,
                          color: textColor,
                        ),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}

class DialogButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color backgroundColor;
  final List<Color> colors;
  final bool? isLoading;
  final Color textColor;
  final Color? borderColor;
  final String? icondData;
  final double borderRadius;
  final bool small;
  final FontWeight fontWeight;

  const DialogButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.colors = const [],
    this.backgroundColor = Colors.white,
    this.textColor = Colors.white,
    this.borderColor,
    this.isLoading,
    this.icondData,
    this.small = false,
    this.borderRadius = 5,
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isLoading != null && isLoading!) {
          return;
        }
        onPressed();
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(small ? $styles.insets.xs : $styles.insets.sm),
        decoration: BoxDecoration(
          border: borderColor == null
              ? null
              : Border.all(color: borderColor!, width: 2),
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
          color: colors.isNotEmpty ? null : backgroundColor,
          gradient: colors.isEmpty ? null : LinearGradient(colors: colors),
          boxShadow: colors.isEmpty
              ? null
              : [
                  BoxShadow(
                    offset: const Offset(0, 5),
                    spreadRadius: -2,
                    blurRadius: 10,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withValues(alpha: .5),
                  ),
                ],
        ),
        child: isLoading != null && isLoading!
            ? Center(
                child: SizedBox(
                  height: 20.0,
                  width: 20.0,
                  child: CircularProgressIndicator(color: textColor),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icondData != null)
                    SvgIcon(icondData!, color: textColor, size: 22.0)
                  else
                    const SizedBox.shrink(),
                  Gap($styles.insets.xs).visibleWhen(icondData != null),
                  AutoSizeText(
                    title,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: fontWeight,
                      fontSize: 15.0,
                      color: textColor,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
