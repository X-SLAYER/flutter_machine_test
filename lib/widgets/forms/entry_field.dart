// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import '../../constant/styles.dart';
import '../../utils/core/extensions/extensions_export.dart';
import '../../utils/core/masks/mask_input_text.dart';
import '../common/svg_icon.dart';
import 'invalid_feedback.dart';

class EntryField extends StatelessWidget {
  final String? name;
  final String? title;
  final String? hint;
  final String? icon;
  final bool isPassword;
  final FocusNode? node;
  final String? suffix;
  final Widget? suffixWidget;
  final TextInputType keyboard;
  final void Function(String name, String value)? onChanged;
  final void Function()? onTap;
  final bool obsecureText;
  final bool readOnly;
  final bool isRequired;
  final String? error;
  final String? defaultValue;
  final int maxLines;
  final bool withMargin;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final ValueChanged<String?>? onSubmitted;
  final bool alwaysEnabled;

  const EntryField({
    super.key,
    this.name,
    this.title,
    this.hint,
    this.icon,
    this.isPassword = false,
    this.node,
    this.suffix,
    this.suffixWidget,
    this.keyboard = TextInputType.emailAddress,
    this.onChanged,
    this.obsecureText = true,
    this.onTap,
    this.readOnly = false,
    this.isRequired = false,
    this.error,
    this.defaultValue,
    this.maxLines = 1,
    this.withMargin = true,
    this.inputFormatters,
    this.controller,
    this.onSubmitted,
    this.alwaysEnabled = false,
  });

  @override
  Widget build(BuildContext context) {
    var _defaultValue = defaultValue;
    if (inputFormatters != null &&
        inputFormatters!.isNotEmpty &&
        defaultValue != null) {
      if (inputFormatters?.first is FilteringTextInputFormatter) {
        _defaultValue = defaultValue;
      } else {
        _defaultValue = (inputFormatters!.first as MaskTextInputFormatter)
            .maskText(defaultValue!);
      }
    }
    return Container(
      margin: withMargin
          ? EdgeInsets.symmetric(vertical: $styles.insets.xs)
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null) ...[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title ?? '',
                  style: context.textTheme.bodyMedium!.copyWith(fontSize: 12.0),
                ).paddingHV(h: $styles.insets.xxs),
                Text(
                  '*',
                  style: TextStyle(
                    color: $styles.colors.accent2,
                    fontWeight: FontWeight.bold,
                  ),
                ).visibleWhen(isRequired),
              ],
            ),
            Gap($styles.insets.xs),
          ],
          TextFormField(
            onFieldSubmitted: onSubmitted,
            cursorColor: $styles.colors.greyMedium,
            controller:
                controller ??
                (defaultValue == null
                    ? null
                    : (TextEditingController()
                        ..text = _defaultValue!
                        ..selection = TextSelection.collapsed(
                          offset: _defaultValue.length,
                        ))),
            readOnly: readOnly,
            onChanged: onChanged == null
                ? null
                : (value) {
                    if (inputFormatters != null) {
                      try {
                        final formatter =
                            inputFormatters!.first as MaskTextInputFormatter;
                        onChanged!(name!, formatter.getUnmaskedText());
                      } catch (e) {
                        onChanged!(name!, value);
                      }
                    } else {
                      onChanged!(name!, value);
                    }
                  },
            maxLines: maxLines,
            focusNode: node,
            obscureText: isPassword && obsecureText,
            textInputAction: onSubmitted != null
                ? TextInputAction.search
                : TextInputAction.done,
            keyboardType: keyboard,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: context.textTheme.bodySmall,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular($styles.corners.nm),
                borderSide: BorderSide(
                  width: 1.8,
                  color: alwaysEnabled && error == null
                      ? $styles.colors.greyMedium
                      : (error == null || error!.isEmpty)
                      ? Colors.transparent
                      : Colors.red,
                ),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: alwaysEnabled
                      ? $styles.colors.greyMedium
                      : Colors.transparent,
                  width: 1.8,
                ),
                borderRadius: BorderRadius.circular($styles.corners.nm),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: alwaysEnabled
                      ? $styles.colors.greyMedium
                      : Colors.transparent,
                  width: 1.8,
                ),
                borderRadius: BorderRadius.circular($styles.corners.nm),
              ),
              fillColor: readOnly ? context.borderColor : context.fillColor,
              filled: true,
              isDense: false,
              suffixText: suffix,
              suffixStyle: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
              prefixIcon: icon != null
                  ? Padding(
                      padding: EdgeInsets.only(
                        left: $styles.insets.min,
                        right: $styles.insets.min,
                      ),
                      child: SvgIcon(
                        icon!,
                        size: 15.0,
                        color: $styles.colors.silver,
                      ),
                    )
                  : null,
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        obsecureText
                            ? CupertinoIcons.eye_slash
                            : CupertinoIcons.eye,
                        size: 18.0,
                      ),
                      onPressed: onTap,
                    )
                  : suffixWidget,
            ),
            inputFormatters: inputFormatters,
          ),
          Gap($styles.insets.xs),
          InvalidFeedBack(error),
        ],
      ),
    );
  }
}
