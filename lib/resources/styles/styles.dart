import 'package:crypto_coins_list/resources/colors/colors.dart';
import 'package:flutter/material.dart';

class AppStyles {
  const AppStyles._();

  static const cryproCoinDetailsStyle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w700,
  );

  static const titleTextStyle = TextStyle(
    color: AppColors.defaultColor,
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
  );

  static const headlineMedium = TextStyle(
    color: AppColors.defaultColor,
    fontWeight: FontWeight.w500,
    fontSize: 20.0,
  );

  static const bodyMedium = TextStyle(
    color: AppColors.defaultColor,
    fontWeight: FontWeight.w700,
    fontSize: 20.0,
  );

  static final labelSmall = TextStyle(
    color: AppColors.defaultColor.withOpacity(0.6),
    fontWeight: FontWeight.w700,
    fontSize: 14.0,
  );
}
