import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/models/models.dart';
import 'package:crypto_coins_list/pages/crypto_coin/crypto_coin.dart';
import 'package:crypto_coins_list/pages/crypto_list/crypto_list.dart';
import 'package:flutter/material.dart';
// import 'package:crypto_coins_list/pages/crypto_coin/crypto_coin.dart';
// import 'package:crypto_coins_list/pages/crypto_list/crypto_list.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: CryptoListRoute.page, path: '/'),
        AutoRoute(page: CryptoCoinRoute.page),
      ];
}

// final routes = {
//   '/': (context) => const CryptoListScreen(),
//   '/coin': (context) => const CryptoCoinScreen(),
// };
