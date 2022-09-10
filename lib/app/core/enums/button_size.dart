import 'package:get/get.dart';

enum ButtonSize {
  small('sm'),
  medium('md'),
  large('lg');

  final String value;

  const ButtonSize(this.value);

  double get width {
    switch (value) {
      case 'sm':
        return Get.width * 0.28;
      case 'md':
        return Get.width * 0.42;
      case 'lg':
      default:
        return Get.width;
    }
  }

  double get spacing {
    switch (value) {
      case 'sm':
        return 62;
      case 'md':
        return 25;
      case 'lg':
      default:
        return 16;
    }
  }
}
