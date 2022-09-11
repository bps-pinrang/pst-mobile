import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../core/utils/view_helper.dart';
import '../core/values/color.dart';

class AppDrodpownField extends StatelessWidget {
  const AppDrodpownField({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.label,
    this.hint,
    this.focusNode,
    required this.prefixIcon,
    this.validator,
    this.validationMessage,
    this.enabled = true,
    required this.formControl,
  });

  final List<DropdownMenuItem> items;
  final dynamic value;
  final Function(dynamic) onChanged;
  final String? label;
  final String? hint;
  final FocusNode? focusNode;
  final IconData prefixIcon;
  final bool enabled;
  final String? Function(dynamic)? validator;
  final Map<String, String Function(Object)>? validationMessage;
  final AbstractControl<dynamic> formControl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return ValueBuilder<bool?>(
      builder: (isFocus, onFocusChange) => Focus(
        onFocusChange: onFocusChange,
        focusNode: focusNode,
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
                  child: ButtonTheme(
                    alignedDropdown: true,
                    padding: EdgeInsets.zero,
                    child: ReactiveDropdownField(
                      items: items,
                      onChanged: onChanged,
                      validationMessages: validationMessage,
                      focusNode: focusNode,
                      isDense: true,
                      isExpanded: true,
                      elevation: 4,
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      formControl: (formControl as FormControl),
                      iconEnabledColor: theme.dividerColor,
                      iconDisabledColor: theme.disabledColor,
                      focusColor: theme.primaryColor,
                      icon: Icon(
                        Icons.arrow_drop_down_rounded,
                        color:
                            isFocus ? theme.primaryColor : theme.dividerColor,
                      ),

                      decoration: InputDecoration(
                        enabled: enabled,
                        iconColor: checkFloatingLabelColor(
                          isFocus,
                          isValid,
                          formControl,
                          theme,
                        ),
                        helperStyle: textTheme.caption,
                        hintText: hint,
                        hintStyle: textTheme.bodyMedium,
                        isDense: true,
                        labelText: label,
                        floatingLabelStyle: textTheme.bodyMedium?.copyWith(
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
                        alignLabelWithHint: false,
                      ),
                    ),
                  ),
                )
              ],
            );
          },
          stream: formControl.statusChanged,
          initialData: ControlStatus.pending,
        ),
      ),
      initialValue: false,
    );
  }
}
