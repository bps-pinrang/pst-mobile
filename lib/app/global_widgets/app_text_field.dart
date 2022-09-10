import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pst_online/app/core/values/color.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../core/utils/view_helper.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.label,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
    this.readOnly = false,
    this.enabled = true,
    required this.prefixIcon,
    this.suffixIcon,
    this.helperText,
    this.hintText,
    this.maxLines,
    this.initialValue,
    this.obscureText = false,
    this.focusNode,
    this.onSubmitted,
    this.textInputAction,
    this.validationMessages,
    required this.formControl,
    this.obscuringCharacter = '*',
  });

  final String label;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;

  final bool readOnly;
  final bool enabled;

  final Widget? suffixIcon;
  final IconData prefixIcon;
  final String? helperText;
  final String? hintText;
  final int? maxLines;
  final String? initialValue;

  final bool obscureText;
  final String obscuringCharacter;
  final FocusNode? focusNode;
  final void Function(FormControl)? onSubmitted;
  final TextInputAction? textInputAction;
  final AbstractControl<dynamic> formControl;
  final Map<String, String Function(Object)>? validationMessages;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return ValueBuilder<bool?>(
      builder: (isFocus, onFocusChange) => Focus(
        onFocusChange: onFocusChange,
        child: StreamBuilder(
          builder: (_, snapshot) {
            var isValid = false;

            if (snapshot.hasData) {
              isValid = snapshot.data == ControlStatus.valid;
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  prefixIcon,
                  color: checkFloatingLabelColor(
                      isFocus!, isValid, formControl, theme),
                ),
                horizontalSpace(8),
                Expanded(
                  child: ReactiveTextField(
                    focusNode: focusNode,
                    obscureText: obscureText,
                    validationMessages: validationMessages,
                    onSubmitted: onSubmitted,
                    keyboardType: keyboardType,
                    textInputAction: textInputAction,
                    readOnly: readOnly,
                    inputFormatters: inputFormatters,
                    formControl: formControl as FormControl,
                    maxLines: maxLines,
                    maxLength: maxLength,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: InputDecoration(
                      enabled: enabled,
                      iconColor: checkFloatingLabelColor(
                        isFocus,
                        isValid,
                        formControl,
                        theme,
                      ),
                      suffixIcon: suffixIcon,
                      helperText: helperText,
                      helperStyle: textTheme.caption,
                      hintText: hintText,
                      hintStyle: textTheme.bodyText2,
                      isDense: false,
                      label: Text(
                        label,
                      ),
                      floatingLabelStyle: textTheme.bodyText2?.copyWith(
                        color: checkFloatingLabelColor(
                            isFocus, isValid, formControl, theme),
                        fontWeight: FontWeight.w600,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: theme.dividerColor,
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: kColorPrimary,
                        ),
                      ),
                      disabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: theme.disabledColor, width: 2),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: theme.errorColor,
                          width: 2,
                        ),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: theme.errorColor, width: 2),
                      ),
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
              ],
            );
          },
          initialData: ControlStatus.pending,
          stream: formControl.statusChanged,
        ),
      ),
      initialValue: false,
    );
  }
}
