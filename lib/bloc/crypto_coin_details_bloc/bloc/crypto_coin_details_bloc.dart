import 'package:crypto_coins_list/models/models.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'crypto_coin_details_event.dart';
part 'crypto_coin_details_state.dart';

class CryptoCoinDetailsBloc
    extends Bloc<CryptoCoinDetailsEvent, CryptoCoinDetailsState> {
  CryptoCoinDetailsBloc(this.coinsRepository)
      : super(CryptoCoinDetailsInitial()) {
    on<LoadCryptoCoinDetailsEvent>(_loadCoinDetails);
  }
  final AbstractCoinsRepository coinsRepository;

  Future<void> _loadCoinDetails(
    LoadCryptoCoinDetailsEvent event,
    Emitter<CryptoCoinDetailsState> emit,
  ) async {
    try {
      if (state is! CryptoCoinDetailsLoadedState) {
        emit(CryptoCoinDetailsLoadingState());
      }

      final coinDetails =
          await coinsRepository.getCryptoCoinDetails(event.nameCode);
      emit(CryptoCoinDetailsLoadedState(coinDetails: coinDetails));
    } catch (e) {
      emit(CryptoCoinDetailsLoadingFailureState(exception: e));
    }
  }
}
