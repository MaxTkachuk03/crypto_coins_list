// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'crypto_coin_details_bloc.dart';

abstract class CryptoCoinDetailsEvent extends Equatable {}

class LoadCryptoCoinDetailsEvent extends CryptoCoinDetailsEvent {
  LoadCryptoCoinDetailsEvent({
    required this.nameCode,
  });
  final String nameCode;

  @override
  List<Object?> get props => [nameCode];
}
