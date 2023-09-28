part of 'check_internet_connection_bloc.dart';

class CheckInternetConnectionEvent extends Equatable {
  const CheckInternetConnectionEvent({this.checkInternet});
  final bool? checkInternet;

  @override
  List<Object?> get props => [
        checkInternet,
      ];
}
