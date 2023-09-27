import 'package:crypto_coins_list/models/crypto_coin.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CryptoCoinsLocal extends AbstractCoinsLocal {
  CryptoCoinsLocal({
    required this.cryptoCoinsBox,
  });

  final Box<CryptoCoin> cryptoCoinsBox;

  @override
  List<CryptoCoin> getLocalList() {
    final List<CryptoCoin> cryptoCoinsList = cryptoCoinsBox.values.toList();
    cryptoCoinsList
        .sort((a, b) => b.details.priceInUSD.compareTo(a.details.priceInUSD));
    return cryptoCoinsList;
  }

  @override
  CryptoCoin getLocalDetails(String nameCode) {
    return cryptoCoinsBox.get(nameCode)!;
  }
}
