import 'package:crypto_coins_list/bloc/check_internet_connection_bloc/bloc/check_internet_connection_bloc.dart';
import 'package:crypto_coins_list/generated/l10n.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/check_internet_connection/check_internet_conection.dart';
import 'package:crypto_coins_list/resources/resources.dart';
import 'package:crypto_coins_list/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CheckInternetConnectionBloc(
            GetIt.I<InternetConnection>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        localizationsDelegates: const [
          S.delegate,
          // Локалізація від самого FLuter
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        debugShowCheckedModeBanner: false,
        title:
            "CryptoCurrenciesList", // Не ставимо в MaterialApp: S.of(context).cryptocurrencieslist,;
        // Бо в дереві віджетів ще не з'явився екземпляр S
        theme: darkTheme,
        locale: const Locale('en'),
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
      ),
    );
  }
}
