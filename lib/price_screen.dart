import 'dart:io' show Platform;

import 'package:bitcoin_ticker_flutter/services/crypto.dart';
import 'package:bitcoin_ticker_flutter/widgets/crypto_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';
  Map cryptoValues = {};

  CryptoService crypto = CryptoService();

  @override
  initState() {
    super.initState();
    updateRates(selectedCurrency);
  }

  Future<void> updateRates(String currency) async {
    var cryptoData = await crypto.cryptoValue(currency);

    setState(() {
      cryptoValues = cryptoData;
      selectedCurrency = currency;
    });
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> items = [];

    for (String currency in currenciesList) {
      var item = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );

      items.add(item);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: items,
      onChanged: (currency) => updateRates(currency!),
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> items = [];

    for (String currency in currenciesList) items.add(Text(currency));

    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (index) => updateRates(currenciesList[index]),
      children: items,
    );
  }

  List<CryptoCard> cryptoCards() {
    List<CryptoCard> cryptos = [];

    for (String crypto in cryptoList) {
      cryptos.add(CryptoCard(
          crypto: crypto,
          cryptoValue: cryptoValues[crypto] ?? '?',
          selectedCurrency: selectedCurrency));
    }

    return cryptos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            children: cryptoCards(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
