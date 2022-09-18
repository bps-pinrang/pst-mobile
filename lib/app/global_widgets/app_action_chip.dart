import 'package:flutter/material.dart';


class AppActionChip extends StatelessWidget {
  const AppActionChip({
    super.key,
    required this.label,
    required this.bgColor,
    required this.onPressed,
  });

  final String label;
  final Color bgColor;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return ActionChip(
      label: Text(label),

      avatar: const Icon(Icons.arrow_drop_down),
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      side: BorderSide(
        width: 1,
        color: theme.dividerColor,
      ),
      onPressed: onPressed,
      surfaceTintColor: theme.disabledColor,
      labelStyle: textTheme.caption?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
