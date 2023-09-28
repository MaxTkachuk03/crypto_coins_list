import 'package:crypto_coins_list/generated/l10n.dart';
import 'package:flutter/material.dart';

class FailureLoadingList extends StatelessWidget {
  const FailureLoadingList({
    super.key,
    this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            S.of(context).somethingWentWrong,
            style: theme.textTheme.headlineMedium,
          ),
          Text(
            S.of(context).pleaseTryAgainLater,
            style: theme.textTheme.labelSmall?.copyWith(fontSize: 16.0),
          ),
          const SizedBox(height: 30.0),
          TextButton(
            onPressed: onPressed,
            child: Text(
              S.of(context).tryAgain,
            ),
          ),
        ],
      ),
    );
  }
}
