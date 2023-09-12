import 'package:flutter/material.dart';

class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({super.key});

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  String? coinName;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    //! Перший метод(кращий, ефективніший)
    assert(args!= null && args is String, 'You must provide String args');
    coinName = args as String;
    //! Другий метод
    // if (args == null) {
    //   debugPrint('You must provide args');
    //   return;
    // }
    // if (args is! String) {
    //   debugPrint('You must provide String args');
    //   return;
    // }
    // coinName = args;
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(coinName ?? "..."),
        leading: IconButton(
          enableFeedback: true,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}