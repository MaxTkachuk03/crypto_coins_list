import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnection{
  const InternetConnection();
  
  Future<bool> checkInternetConnection() async {
  ConnectivityResult result = await (Connectivity().checkConnectivity());

  if(result == ConnectivityResult.none){
    return false;
  }
  else {
    return true;
  }
}
}