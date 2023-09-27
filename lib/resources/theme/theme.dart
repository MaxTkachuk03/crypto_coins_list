import 'package:crypto_coins_list/resources/resources.dart';
import 'package:flutter/material.dart';

final darkTheme = ThemeData(
        scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: AppColors.primarySwatch),
        useMaterial3: true,
        indicatorColor:AppColors.indicatorColor,
        listTileTheme: const ListTileThemeData(
          iconColor: AppColors.defaultColor,
        ),
        dividerColor: AppColors.dividerColor,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          titleTextStyle: AppStyles.titleTextStyle,
          backgroundColor: AppColors.backgroundColor,
          surfaceTintColor: AppColors.backgroundColor,
          iconTheme: IconThemeData(
            color: AppColors.defaultColor,
          ),
        ),
        textTheme: TextTheme(
          headlineMedium: AppStyles.headlineMedium,
          bodyMedium: AppStyles.bodyMedium,
          labelSmall: AppStyles.labelSmall,
        ),
      );