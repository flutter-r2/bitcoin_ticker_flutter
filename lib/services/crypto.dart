import 'package:bitcoin_ticker_flutter/coin_data.dart';
import 'package:bitcoin_ticker_flutter/services/network.dart';

import '../models/environment.dart';

const String coinApiBaseURL = "https://rest.coinapi.io/v1/exchangerate";

class CryptoService {
  Future<dynamic> cryptoValue(String currency) async {
    Map values = {};

    for (String crypto in cryptoList) {
      NetworkHelper http = NetworkHelper(
          '$coinApiBaseURL/$crypto/$currency?apikey=${Environment.apiKey}');

      var httpResponse = await http.fetchCryptoData();
      values[crypto] = httpResponse['rate'].toStringAsFixed(2);
    }

    return values;
  }
}
