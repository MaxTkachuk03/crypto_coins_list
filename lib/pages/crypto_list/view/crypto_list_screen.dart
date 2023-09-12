import 'package:crypto_coins_list/pages/crypto_list/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({
    super.key,
  });

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('CryptoCurrenciesList'),
      ),
      body: ListView.separated(
        itemCount: 10,
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: theme.dividerColor,
          );
        },
        itemBuilder: (context, index) {
          const coinName = "Bitcoin";
          return const CryptoCoinTile(coinName: coinName);
        },
      ),
    );
  }
}

