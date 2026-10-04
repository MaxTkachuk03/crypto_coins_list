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

  /// CoinGecko free API (CryptoCompare now requires a paid API key).
  static const String _marketsUrl =
      'https://api.coingecko.com/api/v3/coins/markets';

  static const Map<String, String> _coinIdsBySymbol = {
    'BTC': 'bitcoin',
    'ETH': 'ethereum',
    'BNB': 'binancecoin',
    'AVAX': 'avalanche-2',
    'SOL': 'solana',
    'DOGE': 'dogecoin',
    'XRP': 'ripple',
    'ADA': 'cardano',
  };

  static String get _coinIdsQuery => _coinIdsBySymbol.values.join(',');

  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    final List<CryptoCoin> cryptoCoinsList = await _fetchCoinsListFromApi();

    final cryptoCoinsMap = {for (var e in cryptoCoinsList) e.name: e};
    await cryptoCoinsBox.putAll(cryptoCoinsMap);

    return cryptoCoinsList;
  }

  Future<List<CryptoCoin>> _fetchCoinsListFromApi() async {
    final response = await dio.get(
      _marketsUrl,
      queryParameters: {
        'vs_currency': 'usd',
        'ids': _coinIdsQuery,
        'order': 'market_cap_desc',
        'sparkline': false,
      },
    );

    final data = response.data as List<dynamic>;
    return data
        .map((item) => _mapMarketItem(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<CryptoCoin> getCryptoCoinDetails(String nameCode) async {
    final coin = await _fetchCoinDetailsFromApi(nameCode);
    cryptoCoinsBox.put(nameCode, coin);
    return coin;
  }

  Future<CryptoCoin> _fetchCoinDetailsFromApi(String nameCode) async {
    final coinId = _coinIdsBySymbol[nameCode.toUpperCase()];
    if (coinId == null) {
      throw ArgumentError('Unsupported coin symbol: $nameCode');
    }

    final response = await dio.get(
      _marketsUrl,
      queryParameters: {
        'vs_currency': 'usd',
        'ids': coinId,
        'sparkline': false,
      },
    );

    final data = response.data as List<dynamic>;
    if (data.isEmpty) {
      throw StateError('No market data for $nameCode');
    }

    return _mapMarketItem(data.first as Map<String, dynamic>);
  }

  CryptoCoin _mapMarketItem(Map<String, dynamic> item) {
    final symbol = (item['symbol'] as String).toUpperCase();
    final lastUpdated = DateTime.parse(item['last_updated'] as String);

    final details = CryptoCoinDetails(
      priceInUSD: (item['current_price'] as num).toDouble(),
      imageUrl: item['image'] as String,
      toSymbol: 'USD',
      lastUpdate: lastUpdated,
      // Keep field names aligned with UI labels (not CryptoCompare JSON quirk).
      low24Hour: (item['low_24h'] as num).toDouble(),
      high24Hour: (item['high_24h'] as num).toDouble(),
    );

    return CryptoCoin(
      name: symbol,
      details: details,
    );
  }
}
