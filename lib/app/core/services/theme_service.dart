import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pst_online/app/core/values/strings.dart';

class ThemeService {
  final _box = GetStorage();

  ThemeMode get themeMode {
    if (!_box.hasData(kStorageKeyIsDarkMode)) {
      return ThemeMode.light;
    }

    return _box.read(kStorageKeyIsDarkMode) ? ThemeMode.dark : ThemeMode.light;
  }

  bool isLightTheme() =>
      !_box.hasData(kStorageKeyIsDarkMode) || !_box.read(kStorageKeyIsDarkMode);

  void _saveThemeSetting(bool setting) => _box.write(
        kStorageKeyIsDarkMode,
        setting,
      );

  void changeThemeMode() {
    _saveThemeSetting(!Get.isDarkMode);
    Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
  }
}
