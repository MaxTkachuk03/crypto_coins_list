import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crypto_coin_details.g.dart';

// Генерація сереалізації flutter pub run build_runner build --delete-conflicting-outputs

@JsonSerializable()
class CryptoCoinDetails extends Equatable {
  const CryptoCoinDetails({
    required this.priceInUSD,
    required this.imageUrl,
    required this.toSymbol,
    required this.lastUpdate,
    required this.low24Hour,
    required this.high24Hour,
  });

  @JsonKey(name: 'PRICE')
  final double priceInUSD;

  @JsonKey(name: 'IMAGEURL')
  final String imageUrl;

  @JsonKey(name: 'TOSYMBOL')
  final String toSymbol;

  @JsonKey(
    name: "LASTUPDATE",
    toJson: _dateTimetoJson,
    fromJson: _dateTimeFromJson,
  )
  final DateTime lastUpdate;

  @JsonKey(name: "HIGH24HOUR")
  final double low24Hour;

  @JsonKey(name: "LOW24HOUR")
  final double high24Hour;

  String get fullImageUrl => 'https://www.cryptocompare.com/$imageUrl';

  factory CryptoCoinDetails.fromJson(Map<String, dynamic> json) =>
      _$CryptoCoinDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoCoinDetailsToJson(this);

  static int _dateTimetoJson(DateTime time) => time.millisecondsSinceEpoch;
  static DateTime _dateTimeFromJson(int millisecondsSinceEpoch) =>
      DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);

  @override
  List<Object> get props =>
      [toSymbol, lastUpdate, low24Hour, high24Hour, priceInUSD, imageUrl];
}
