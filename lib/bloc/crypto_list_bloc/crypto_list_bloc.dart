import 'dart:async';

import 'package:crypto_coins_list/models/models.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'crypto_list_event.dart';
part 'crypto_list_state.dart';

class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState> {
  CryptoListBloc(this.coinsRepository, this.checkInternet, this.coinsLocal)
      : super(CryptoListInitialState()) {
    on<LoadCryptoListEvent>((event, emit) async {
      try {
        final result = await checkInternet.checkInternetConnection();
        if (state is! CryptoListLoadedState) {
          emit(CryptoListLoadingState());
        }
        if (result == true) {
          final coinsList = await coinsRepository.getCoinsList();
          emit(CryptoListLoadedState(coinsList: coinsList));
        } else {
          final coinsList = coinsLocal.getLocalList();
          emit(CryptoListLoadedState(coinsList: coinsList));
        }
      } catch (exception, stackTrace) {
        emit(CryptoListLoadingFailureState(exception: exception));
        GetIt.I<Talker>().handle(exception, stackTrace);
      } finally {
        event.completer?.complete();
      }
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }

  final AbstractCoinsRepository coinsRepository;
  final AbstractCoinsLocal coinsLocal;
  final InternetConnection checkInternet;
}
