import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    super.key,
    required this.width,
    required this.height,
    this.highlightColor,
    this.shape,
  });
  final double width;
  final double height;
  final Color? highlightColor;
  final BoxShape? shape;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Shimmer.fromColors(
      baseColor: highlightColor ?? theme.disabledColor.withOpacity(0.3),
      highlightColor: theme.disabledColor.withOpacity(0.02),
      child: Container(
        decoration: BoxDecoration(
          color: theme.disabledColor.withOpacity(0.3),
          borderRadius: shape == null ? BorderRadius.circular(10.0) : null,
          shape: shape ?? BoxShape.rectangle,
        ),
        height: height,
        width: width,
      ),
    );
  }
}
