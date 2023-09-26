import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/models/models.dart';
import 'package:crypto_coins_list/router/router.dart';
import 'package:flutter/material.dart';

class CryptoCoinTile extends StatelessWidget {
  const CryptoCoinTile({
    super.key,
    required this.coin,
  });

  final CryptoCoin coin;
  static const double sizeImage = 50.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final coinDetails = coin.details;
    return ListTile(
      leading: Image.network(
        coinDetails.fullImageUrl,
        height: sizeImage,
        width: sizeImage,
      ),
      title: Text(
        coin.name,
        style: theme.textTheme.bodyMedium,
      ),
      subtitle: Text(
        "${coinDetails.priceInUSD.toStringAsFixed(3)}\$",
        style: theme.textTheme.labelSmall,
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        AutoRouter.of(context).push(CryptoCoinRoute(coin: coin));
        // Navigator.of(context).pushNamed(
        //   "/coin",
        //   arguments: coin,
        // );
      },
    );
  }
}
