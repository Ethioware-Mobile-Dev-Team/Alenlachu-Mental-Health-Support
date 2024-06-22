import 'package:flutter/material.dart';
import 'app_colors.dart';

final ThemeData appTheme = ThemeData(
  colorScheme: const ColorScheme(
    primary: AppColors.primary,
    primaryContainer: AppColors.primaryVariant,
    secondary: AppColors.secondary,
    secondaryContainer: AppColors.secondaryVariant,
    surface: AppColors.surface,
    error: AppColors.error,
    onPrimary: AppColors.onPrimary,
    onSecondary: AppColors.onSecondary,
    onSurface: AppColors.onSurface,
    onError: AppColors.onError,
    brightness: Brightness.light,
  ),
  primaryColor: AppColors.primary,
  hintColor: AppColors.secondary,
  scaffoldBackgroundColor: AppColors.background,
  appBarTheme: const AppBarTheme(
    color: AppColors.primary,
    iconTheme: IconThemeData(color: AppColors.onPrimary),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: AppColors.primary,
    textTheme: ButtonTextTheme.primary,
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(color: AppColors.onBackground),
    headlineMedium: TextStyle(color: AppColors.onBackground),
    headlineSmall: TextStyle(color: AppColors.onBackground),
  ),
);
