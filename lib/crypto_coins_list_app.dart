import 'package:crypto_coins_list/resources/resources.dart';
import 'package:crypto_coins_list/router/router.dart';
import 'package:flutter/material.dart';

class CryptoCurrenciesListApp extends StatelessWidget {
  const CryptoCurrenciesListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CryptoCurrenciesList',
      theme: darkTheme,
      //! Перший метод
      routes: routes,
      //! Другий метод
      // routes: {
      //   '/coins-list' : (context) => const CryptoListScreen(),
      //   '/coin' : (context) => const CryptoCoinScreen(),
      // },
      // initialRoute: "/coins-list",
    );
  }
}
