import 'package:crypto_coins_list/generated/l10n.dart';
import 'package:crypto_coins_list/resources/resources.dart';
import 'package:crypto_coins_list/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CryptoCurrenciesListApp extends StatefulWidget {
  const CryptoCurrenciesListApp({super.key});

  @override
  State<CryptoCurrenciesListApp> createState() =>
      _CryptoCurrenciesListAppState();
}

class _CryptoCurrenciesListAppState extends State<CryptoCurrenciesListApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: const [
        S.delegate,
        // Локалізація від самого FLuter
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: "CryptoCurrenciesList", // Не ставимо в MaterialApp: S.of(context).cryptocurrencieslist,; 
                                    // Бо в дереві віджетів ще не з'явився екземпляр S
      theme: darkTheme,
      //locale: const Locale('en'),
      routerConfig: _appRouter.config(
        navigatorObservers: () => [
          TalkerRouteObserver(GetIt.I<Talker>()),
        ],
      ),
      //! Перший метод
      // routes: routes,
      //! Другий метод
      // routes: {
      //   '/coins-list' : (context) => const CryptoListScreen(),
      //   '/coin' : (context) => const CryptoCoinScreen(),
      // },
      // initialRoute: "/coins-list",
    );
  }
}
