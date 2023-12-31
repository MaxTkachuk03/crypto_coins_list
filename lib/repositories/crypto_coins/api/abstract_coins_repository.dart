import 'package:crypto_coins_list/models/models.dart';

abstract class AbstractCoinsRepository{
   Future<List<CryptoCoin>> getCoinsList();
   Future<CryptoCoin> getCryptoCoinDetails(String nameCode);
}