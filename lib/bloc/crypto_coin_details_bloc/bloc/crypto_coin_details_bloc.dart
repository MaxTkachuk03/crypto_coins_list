import 'package:crypto_coins_list/models/models.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'crypto_coin_details_event.dart';
part 'crypto_coin_details_state.dart';

class CryptoCoinDetailsBloc
    extends Bloc<CryptoCoinDetailsEvent, CryptoCoinDetailsState> {
  CryptoCoinDetailsBloc(
      this.coinsRepository, this.coinsLocal, this.checkInternet)
      : super(CryptoCoinDetailsInitialState()) {
    on<LoadCryptoCoinDetailsEvent>(_loadCoinDetails);
  }
  final AbstractCoinsRepository coinsRepository;
  final AbstractCoinsLocal coinsLocal;
  final InternetConnection checkInternet;

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }

  Future<void> _loadCoinDetails(
    LoadCryptoCoinDetailsEvent event,
    Emitter<CryptoCoinDetailsState> emit,
  ) async {
    final result = await checkInternet.checkInternetConnection();
    try {
      if (state is! CryptoCoinDetailsLoadedState) {
        emit(CryptoCoinDetailsLoadingState());
      }
      if (result == true) {
        final coin = await coinsRepository.getCryptoCoinDetails(event.nameCode);
        emit(CryptoCoinDetailsLoadedState(coin: coin));
      } else {
        final coin = coinsLocal.getLocalDetails(event.nameCode);
        emit(CryptoCoinDetailsLoadedState(coin: coin));
      }
    } catch (exception, stackTrace) {
      emit(CryptoCoinDetailsLoadingFailureState(exception: exception));
      GetIt.I<Talker>().handle(exception, stackTrace);
    }
  }
}
