import 'package:crypto_coins_list/models/models.dart';

abstract class AbstractCoinsLocal {
  List<CryptoCoin> getLocalList();
  CryptoCoin getLocalDetails(String nameCode);
}
