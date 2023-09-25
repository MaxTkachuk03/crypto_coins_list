import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/bloc/crypto_coin_details_bloc/bloc/crypto_coin_details_bloc.dart';
import 'package:crypto_coins_list/models/models.dart';
import 'package:crypto_coins_list/pages/crypto_coin/crypto_coin.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:crypto_coins_list/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({
    super.key,
    required this.coin,
  });

  final CryptoCoin coin;

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  // CryptoCoin? coin;

  final _cryptoCoinDetailsBloc =
      CryptoCoinDetailsBloc(GetIt.I<AbstractCoinsRepository>());

  @override
  void initState() {
    super.initState();

    _cryptoCoinDetailsBloc
        .add(LoadCryptoCoinDetailsEvent(nameCode: widget.coin.name));
  }

  // @override
  // void didChangeDependencies() {
  //   final args = ModalRoute.of(context)?.settings.arguments;
  //   //! Передаємо CryptoCoin
  //   assert(args != null && args is CryptoCoin,
  //       'You must provide Map<String,dynamic> args');
  //   coin = args as CryptoCoin;
  //   _cryptoCoinDetailsBloc
  //       .add(LoadCryptoCoinDetailsEvent(nameCode: coin!.name));
  //   //? Коли args було рядком
  //   //! Перший метод(кращий, ефективніший)
  //   // assert(args!= null && args is String, 'You must provide String args');
  //   // coinName = args as String;
  //   //! Другий метод
  //   // if (args == null) {
  //   //   debugPrint('You must provide args');
  //   //   return;
  //   // }
  //   // if (args is! String) {
  //   //   debugPrint('You must provide String args');
  //   //   return;
  //   // }
  //   // coinName = args;

  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          enableFeedback: true,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            AutoRouter.of(context).push(const CryptoListRoute());
            // Navigator.of(context).pushNamed(
            //   '/',
            // );
          },
        ),
      ),
      body: BlocBuilder<CryptoCoinDetailsBloc, CryptoCoinDetailsState>(
        bloc: _cryptoCoinDetailsBloc,
        builder: (context, state) {
          if (state is CryptoCoinDetailsLoadedState) {
            final coin = state.coin;
            final coinDetails = coin.details;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    coinDetails.fullImageUrl,
                    height: 160.0,
                    width: 160.0,
                  ),
                  const SizedBox(height: 24.0),
                  Text(
                    coin.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  BaseCard(
                    child: Center(
                      child: Text(
                        "${coinDetails.priceInUSD} \$",
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  BaseCard(
                      child: Column(
                    children: [
                      _DataRow(
                        title: 'Hight 24 Hour',
                        value: '${coinDetails.high24Hour} \$',
                      ),
                      const SizedBox(height: 6),
                      _DataRow(
                        title: 'Low 24 Hour',
                        value: '${coinDetails.low24Hour} \$',
                      ),
                    ],
                  ))
                ],
              ),
            );
          }
          if (state is CryptoCoinDetailsLoadingFailureState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Something went wrong",
                      style: theme.textTheme.headlineMedium),
                  Text(
                    "Please try again later",
                    style: theme.textTheme.labelSmall?.copyWith(fontSize: 16.0),
                  ),
                  const SizedBox(height: 30.0),
                  TextButton(
                      onPressed: () {
                        _cryptoCoinDetailsBloc.add(LoadCryptoCoinDetailsEvent(
                            nameCode: widget.coin.name));
                      },
                      child: const Text(
                        "Try again",
                      )),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class _DataRow extends StatelessWidget {
  const _DataRow({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140.0,
          child: Text(title),
        ),
        const SizedBox(
          height: 32.0,
        ),
        Flexible(child: Text(value)),
      ],
    );
  }
}
