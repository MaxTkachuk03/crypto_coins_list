import 'package:crypto_coins_list/models/models.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:dio/dio.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository {
  CryptoCoinsRepository({
    required this.dio,
  });

  final Dio dio;
  static const String defaultUrl =
      'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,AVAX,SOL,AID,CAG,DOV&tsyms=USD';

  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    final response = await dio.get(defaultUrl);

    //debugPrint(response.toString());

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final cryptoCoinsList = dataRaw.entries.map((e) {
      final usdData =
          (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
      final price = usdData['PRICE'];
      final imageUrl = usdData['IMAGEURL'];
      return CryptoCoin(
        name: e.key,
        priceInUSD: price,
        imageUrl: 'https://www.cryptocompare.com/$imageUrl',
      );
    }).toList();
    return cryptoCoinsList;
  }

  @override
  Future<CryptoCoinDetails> getCryptoCoinDetails(String nameCode) async {
    final response =await  dio.get('https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$nameCode&tsyms=USD');

    final data = response.data as Map<String,dynamic>;
    final dataRaw = data["RAW"] as Map<String,dynamic>;
    final coinData = dataRaw[nameCode] as Map<String,dynamic>;
    final usdData = coinData["USD"] as Map<String,dynamic>;
    final priceInUSD = usdData["PRICE"];
    final imageUrl = usdData["IMAGEURL"];
    final toSymbol = usdData["TOSYMBOL"];
    final lastUpdate = usdData["LASTUPDATE"];
    final low24Hour = usdData["LOW24HOUR"];
    final high24Hour = usdData["HIGH24HOUR"];
    return CryptoCoinDetails(
      name: nameCode,
      priceInUSD: priceInUSD,
      imageUrl: 'https://www.cryptocompare.com/$imageUrl',
      toSymbol: toSymbol,
      lastUpdate: DateTime.fromMillisecondsSinceEpoch(lastUpdate),
      low24Hour: low24Hour,
      high24Hour: high24Hour,
    );
  }
}
