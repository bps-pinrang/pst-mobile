import 'package:flutter/material.dart';

class AppFilterChip extends StatelessWidget {
  const AppFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final void Function(dynamic value) onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FilterChip(
      label: Text(label),
      onSelected: onSelected,
      selected: selected,
      showCheckmark: true,
      selectedColor: theme.colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      side: BorderSide(
        width: 1,
        color: theme.dividerColor,
      ),
    );
  }
}
