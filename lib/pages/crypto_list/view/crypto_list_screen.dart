import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/bloc/crypto_list_bloc/crypto_list_bloc.dart';
import 'package:crypto_coins_list/generated/l10n.dart';
import 'package:crypto_coins_list/pages/crypto_list/widgets/widgets.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:crypto_coins_list/resources/icons/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

@RoutePage()   
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
    GetIt.I<InternetConnection>(),
    GetIt.I<AbstractCoinsLocal>(),
  );

  @override
  void initState() {
    _cyptoListBloc.add(LoadCryptoListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(S.of(context).cryptocurrencieslist),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TalkerScreen(
                    talker: GetIt.I<Talker>(),
                  ),
                ),
              );
            },
            icon: AppIcon.document,
          ),
        ],
      ),
      body: RefreshIndicator(
        color: theme.indicatorColor,
        backgroundColor: theme.scaffoldBackgroundColor,
        onRefresh: () async {
          final completer = Completer();
          _cyptoListBloc.add(LoadCryptoListEvent(completer: completer));
          return completer.future;
        },
        child: BlocBuilder<CryptoListBloc, CryptoListState>(
          bloc: _cyptoListBloc,
          builder: (context, state) {
            if (state is CryptoListLoaded) {
              return ListView.separated(
                //shrinkWrap: true,
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
            // if (state is CryptoListLoadingFailure) {
            //   return Center(
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Text(
            //           "Something went wrong",
            //           style: theme.textTheme.headlineMedium,
            //         ),
            //         Text(
            //           "Please try again later",
            //           style:
            //               theme.textTheme.labelSmall?.copyWith(fontSize: 16.0),
            //         ),
            //         const SizedBox(height: 30.0),
            //         TextButton(
            //             onPressed: () {
            //               _cyptoListBloc.add(LoadCryptoList());
            //             },
            //             child: const Text(
            //               "Try again",
            //             )),
            //       ],
            //     ),
            //   );
            // }
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
