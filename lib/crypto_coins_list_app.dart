import 'package:crypto_coins_list/resources/resources.dart';
import 'package:crypto_coins_list/router/router.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CryptoCurrenciesListApp extends StatelessWidget {
  const CryptoCurrenciesListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CryptoCurrenciesList',
      theme: darkTheme,
      navigatorObservers: [
        TalkerRouteObserver(GetIt.I<Talker>()),
      ],
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
