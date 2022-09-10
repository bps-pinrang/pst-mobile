import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_phone_form_field/reactive_phone_form_field.dart';

import '../core/utils/view_helper.dart';
import '../core/values/color.dart';

class AppPhoneField extends StatelessWidget {
  const AppPhoneField({
    super.key,
    required this.label,
    this.maxLength,
    this.readOnly = false,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.helperText,
    this.hintText,
    this.maxLines,
    this.defaultCountry = IsoCode.ID,
    this.obscureText = false,
    this.focusNode,
    this.onSubmitted,
    this.textInputAction,
    this.validationMessages,
    required this.formControl,
    this.obscuringCharacter = '*',
  });

  final String label;

  final int? maxLength;

  final bool readOnly;
  final bool enabled;

  final Widget? suffixIcon;
  final IconData? prefixIcon;
  final String? helperText;
  final String? hintText;
  final int? maxLines;
  final IsoCode defaultCountry;

  final bool obscureText;
  final String obscuringCharacter;
  final FocusNode? focusNode;
  final Function()? onSubmitted;
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
              children: [
                Icon(
                  prefixIcon,
                  color: checkFloatingLabelColor(
                    isFocus!,
                    isValid,
                    formControl,
                    theme,
                  ),
                ),
                horizontalSpace(8),
                Expanded(
                  child: ReactivePhoneFormField(
                    selectionHeightStyle: BoxHeightStyle.strut,
                    onSubmitted: onSubmitted,
                    formControl: formControl as FormControl,
                    defaultCountry: IsoCode.ID,
                    focusNode: focusNode,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLength: 15,
                    countryCodeStyle: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    expands: true,
                    countrySelectorNavigator:
                        const CountrySelectorNavigator.draggableBottomSheet(
                      noResultMessage: 'Negara tidak ditemukan!',
                      addSeparator: true,
                    ),
                    validationMessages: validationMessages,
                    maxLines: maxLines,
                    readOnly: readOnly,
                    enabled: enabled,
                    textInputAction: textInputAction,
                    shouldFormat: true,
                    obscureText: obscureText,
                    obscuringCharacter: obscuringCharacter,
                    decoration: InputDecoration(
                      isDense: false,
                      iconColor: checkFloatingLabelColor(
                        isFocus,
                        isValid,
                        formControl,
                        theme,
                      ),
                      suffixIcon: suffixIcon,
                      helperText: helperText,
                      helperStyle: textTheme.caption,
                      labelText: label,
                      hintStyle: textTheme.bodyText2,
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
                    keyboardType: TextInputType.phone,
                  ),
                )
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
