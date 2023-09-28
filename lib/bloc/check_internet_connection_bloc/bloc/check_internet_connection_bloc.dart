import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'check_internet_connection_event.dart';
part 'check_internet_connection_state.dart';

class CheckInternetConnectionBloc
    extends Bloc<CheckInternetConnectionEvent, CheckInternetConnectionState> {
  CheckInternetConnectionBloc(this.checkInternet)
      : super(const CheckInternetConnectionState()) {
    on<CheckInternetConnectionEvent>((event, emit) async {
      final result = await checkInternet.checkInternetConnection();
      emit(CheckInternetConnectionState(checkInternet: result));
    });
  }

  final InternetConnection checkInternet;
}
