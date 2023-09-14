import 'dart:async';

import 'package:crypto_coins_list/blocs/bloc/crypto_list_bloc.dart';
import 'package:crypto_coins_list/models/models.dart';
import 'package:crypto_coins_list/pages/crypto_list/widgets/widgets.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({
    super.key,
  });

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  final _cyptoListBloc = CryptoListBloc(
    GetIt.I<AbstractCoinsRepository>(),
  );

  @override
  void initState() {
    _cyptoListBloc.add(LoadCryptoList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('CryptoCurrenciesList'),
      ),
      body: RefreshIndicator(
        color: theme.indicatorColor,
        backgroundColor: theme.scaffoldBackgroundColor,
        onRefresh: () async {
          final completer = Completer();
          _cyptoListBloc.add(LoadCryptoList(completer: completer));
          return completer.future;
        },
        child: BlocBuilder<CryptoListBloc, CryptoListState>(
          bloc: _cyptoListBloc,
          builder: (context, state) {
            if (state is CryptoListLoaded) {
              return ListView.separated(
                padding: const EdgeInsets.only(top: 16.0),
                itemCount: state.coinsList.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: theme.dividerColor,
                  );
                },
                itemBuilder: (context, index) {
                  final coin = state.coinsList[index];
                  return CryptoCoinTile(coin: coin);
                },
              );
            }
            if (state is CryptoListLoadingFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Something went wrong",
                        style: theme.textTheme.headlineMedium),
                    Text(
                      "Please try again later",
                      style:
                          theme.textTheme.labelSmall?.copyWith(fontSize: 16.0),
                    ),
                    const SizedBox(height: 30.0),
                    TextButton(
                        onPressed: () {
                          _cyptoListBloc.add(LoadCryptoList());
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
      ),
      // _cryptoCoinsList == null
      //     ?
      //     : ListView.separated(
      //         padding: const EdgeInsets.only(top: 16.0),
      //         itemCount: _cryptoCoinsList!.length,
      //         separatorBuilder: (BuildContext context, int index) {
      //           return Divider(
      //             color: theme.dividerColor,
      //           );
      //         },
      //         itemBuilder: (context, index) {
      //           final coin = _cryptoCoinsList![index];
      //           return CryptoCoinTile(coin: coin);
      //         },
      //       ),
    );
  }
}
