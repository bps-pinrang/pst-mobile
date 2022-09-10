import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../core/utils/view_helper.dart';
import '../core/values/color.dart';

class AppPasswordField extends StatelessWidget {
  const AppPasswordField({
    super.key,
    required this.label,
    this.maxLength,
    this.readOnly = false,
    this.enabled = true,
    this.prefixIcon,
    this.helperText,
    this.hintText,
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

  final Widget? prefixIcon;
  final String? helperText;
  final String? hintText;

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
        child: ValueBuilder<bool?>(
          builder: (obscureText, toggleVisible) => StreamBuilder(
            builder: (_, snapshot) {
              var isValid = false;

              if (snapshot.hasData) {
                isValid = snapshot.data == ControlStatus.valid;
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    LineIcons.lock,
                    color: checkFloatingLabelColor(
                        isFocus!, isValid, formControl, theme),
                  ),
                  horizontalSpace(8),
                  Expanded(
                    child: ReactiveTextField(
                      focusNode: focusNode,
                      obscureText: obscureText!,
                      validationMessages: validationMessages,
                      onSubmitted: onSubmitted,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: textInputAction,
                      readOnly: readOnly,
                      formControl: formControl as FormControl,
                      maxLines: 1,
                      maxLength: maxLength,
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        iconColor: checkFloatingLabelColor(
                          isFocus,
                          isValid,
                          formControl,
                          theme,
                        ),
                        enabled: enabled,
                        prefixIcon: prefixIcon,
                        suffixIcon: IconButton(
                          onPressed: () => toggleVisible(!obscureText),
                          icon: Icon(
                            obscureText
                                ? CupertinoIcons.eye_fill
                                : CupertinoIcons.eye_slash_fill,
                            size: 20,
                            color: checkFloatingLabelColor(
                              isFocus,
                              isValid,
                              formControl,
                              theme,
                            ),
                          ),
                        ),
                        helperText: helperText,
                        helperStyle: textTheme.caption,
                        hintText: hintText,
                        hintStyle: textTheme.bodyText2,
                        isDense: true,
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
                  )
                ],
              );
            },
            initialData: ControlStatus.pending,
            stream: formControl.statusChanged,
          ),
          initialValue: true,
        ),
      ),
      initialValue: false,
    );
  }
}
