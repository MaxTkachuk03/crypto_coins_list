// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'crypto_coin_details_bloc.dart';

abstract class CryptoCoinDetailsState extends Equatable {}

final class CryptoCoinDetailsInitial extends CryptoCoinDetailsState {
  @override
  List<Object?> get props => [];
}

class CryptoCoinDetailsLoadingState extends CryptoCoinDetailsState {
  @override
  List<Object?> get props => [];
}

class CryptoCoinDetailsLoadedState extends CryptoCoinDetailsState {
  CryptoCoinDetailsLoadedState({
    required this.coin,
  });

  final CryptoCoin coin;

  @override
  List<Object?> get props => [coin];
}

class CryptoCoinDetailsLoadingFailureState extends CryptoCoinDetailsState {
  CryptoCoinDetailsLoadingFailureState({
    this.exception,
  });

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
