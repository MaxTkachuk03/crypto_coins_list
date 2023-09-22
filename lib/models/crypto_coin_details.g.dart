// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_coin_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptoCoinDetails _$CryptoCoinDetailsFromJson(Map<String, dynamic> json) =>
    CryptoCoinDetails(
      priceInUSD: (json['PRICE'] as num).toDouble(),
      imageUrl: json['IMAGEURL'] as String,
      toSymbol: json['TOSYMBOL'] as String,
      lastUpdate:
          CryptoCoinDetails._dateTimeFromJson(json['LASTUPDATE'] as int),
      low24Hour: (json['HIGH24HOUR'] as num).toDouble(),
      high24Hour: (json['LOW24HOUR'] as num).toDouble(),
    );

Map<String, dynamic> _$CryptoCoinDetailsToJson(CryptoCoinDetails instance) =>
    <String, dynamic>{
      'PRICE': instance.priceInUSD,
      'IMAGEURL': instance.imageUrl,
      'TOSYMBOL': instance.toSymbol,
      'LASTUPDATE': CryptoCoinDetails._dateTimetoJson(instance.lastUpdate),
      'HIGH24HOUR': instance.low24Hour,
      'LOW24HOUR': instance.high24Hour,
    };
