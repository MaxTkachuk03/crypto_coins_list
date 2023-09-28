part of 'check_internet_connection_bloc.dart';

class CheckInternetConnectionState extends Equatable {
  const CheckInternetConnectionState({this.checkInternet = false});

  final bool checkInternet;

  @override
  List<Object> get props => [
        checkInternet,
      ];
}
