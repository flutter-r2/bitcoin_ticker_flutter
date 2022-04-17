import 'dart:io' show Platform;

import 'package:bitcoin_ticker_flutter/services/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String rate = '?';

  CryptoService crypto = CryptoService();

  @override
  initState() {
    super.initState();
    updateRates(selectedCurrency);
  }

  Future<void> updateRates(String currency) async {
    var coinData = await crypto.cryptoValue('BTC', currency);
    setState(() {
      selectedCurrency = currency;
      rate = coinData['rate'].toStringAsFixed(2);
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
      onChanged: (currency) {
        updateRates(currency!);
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Widget> items = [];

    for (String currency in currenciesList) items.add(Text(currency));

    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (index) => print(index),
      children: items,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $rate $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
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
