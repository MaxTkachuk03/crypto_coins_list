import 'package:flutter/material.dart';

final darkTheme = ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 31, 31, 31),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.yellow),
        useMaterial3: true,
        indicatorColor: Colors.limeAccent,
        listTileTheme: const ListTileThemeData(
          iconColor: Colors.white,
        ),
        dividerColor: Colors.white24,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
          backgroundColor: Color.fromARGB(255, 31, 31, 31),
          surfaceTintColor: Color.fromARGB(255, 31, 31, 31),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        textTheme: TextTheme(
          headlineMedium: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20.0,
          ),
          bodyMedium: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 20.0,
          ),
          labelSmall: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontWeight: FontWeight.w700,
            fontSize: 14.0,
          ),
        ),
      );