import 'package:crypto_coins_list/models/models.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository {
  CryptoCoinsRepository({
    required this.dio,
    required this.cryptoCoinsBox,
  });

  final Dio dio;
  final Box<CryptoCoin> cryptoCoinsBox;

  static const String defaultUrl =
      'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,AVAX,SOL,AID,CAG,DOV&tsyms=USD';

  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    final List<CryptoCoin> cryptoCoinsList = await _fetchCoinsListFromApi();

    final cryptoCoinsMap = {for (var e in cryptoCoinsList) e.name: e};
    await cryptoCoinsBox.putAll(cryptoCoinsMap);

    return cryptoCoinsList;
  }

  Future<List<CryptoCoin>> _fetchCoinsListFromApi() async {
    final response = await dio.get(defaultUrl);

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final cryptoCoinsList = dataRaw.entries.map((e) {
      final usdData =
          (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;

      final details = CryptoCoinDetails.fromJson(usdData);
      return CryptoCoin(
        name: e.key,
        details: details,
      );
    }).toList();
    return cryptoCoinsList;
  }

  @override
  Future<CryptoCoin> getCryptoCoinDetails(String nameCode) async {
    final coin = await _fetchCoinDetailsFromApi(nameCode);
    cryptoCoinsBox.put(nameCode, coin);
    return coin;
  }

  Future<CryptoCoin> _fetchCoinDetailsFromApi(String nameCode) async {
    final response = await dio.get(
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$nameCode&tsyms=USD');

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data["RAW"] as Map<String, dynamic>;
    final coinData = dataRaw[nameCode] as Map<String, dynamic>;
    final usdData = coinData["USD"] as Map<String, dynamic>;
    final details = CryptoCoinDetails.fromJson(usdData);

    return CryptoCoin(
      name: nameCode,
      details: details,
    );
  }
}
