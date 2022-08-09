import 'dart:ui';
import '../utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart' as mobx;

class ThemeConstants {
  ThemeConstants();
  static const Color greyBg = Color(0xffF2F4F7);
  static final themeMode = mobx.Observable(ThemeMode.dark);
  static final amoledThemeMode = mobx.Observable(false);
  static final setLightTheme = mobx.Action(() {
    themeMode.value = ThemeMode.light;
  });
  static final setDarkTheme = mobx.Action(() {
    amoledThemeMode.value = false;
    themeMode.value = ThemeMode.dark;
  });

  static final setAmoledTheme = mobx.Action(() {
    themeMode.value = ThemeMode.dark;
    amoledThemeMode.value = true;
  });
}
