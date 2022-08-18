import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pst_online/app/core/services/theme_service.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueBuilder<bool?>(
      builder: (isDark, toggleTheme) => IconButton(
        onPressed: () async {
          toggleTheme.call(Get.isDarkMode);
          ThemeService().changeThemeMode();
        },
        icon: isDark!
            ? const Icon(Icons.dark_mode_outlined)
            : const Icon(Icons.dark_mode),
      ),
      initialValue: ThemeService().isLightTheme(),
    );
  }
}
