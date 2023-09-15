// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:crypto_coins_list/models/models.dart';

class CryptoCoinDetails extends CryptoCoin {
  const CryptoCoinDetails({
    required super.name,
    required super.priceInUSD,
    required super.imageUrl,
    required this.toSymbol,
    required this.lastUpdate,
    required this.low24Hour,
    required this.high24Hour,
  });

  final String toSymbol;
  final DateTime lastUpdate;
  final double low24Hour;
  final double high24Hour;

  @override
  List<Object> get props => super.props
    ..addAll([
      toSymbol,
      lastUpdate,
      low24Hour,
      high24Hour,
    ]);
}
