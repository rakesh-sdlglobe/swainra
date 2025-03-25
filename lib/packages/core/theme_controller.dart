// core/theme_controller.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/scheduler.dart';
import 'theme.dart';

class ThemeController {
  static final ValueNotifier<ThemeData> themeNotifier =
      ValueNotifier(SwainraTheme.darkTheme);

  static const _themeKey = 'isDarkMode';

  /// Call this at app startup
  static Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    // Try to get saved theme
    if (prefs.containsKey(_themeKey)) {
      final isDark = prefs.getBool(_themeKey) ?? true;
      themeNotifier.value = isDark ? SwainraTheme.darkTheme : SwainraTheme.lightTheme;
    } else {
      // If no saved preference, use system setting
      final brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
      themeNotifier.value = brightness == Brightness.dark
          ? SwainraTheme.darkTheme
          : SwainraTheme.lightTheme;
    }
  }

  static Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = themeNotifier.value.brightness == Brightness.dark;
    themeNotifier.value = isDark ? SwainraTheme.lightTheme : SwainraTheme.darkTheme;
    await prefs.setBool(_themeKey, !isDark);
  }
}
