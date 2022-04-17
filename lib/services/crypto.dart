import 'package:bitcoin_ticker_flutter/services/network.dart';

import '../models/environment.dart';

const String coinApiBaseURL = "https://rest.coinapi.io/v1/exchangerate";

class CryptoService {
  Future<dynamic> cryptoValue(String crypto, String currency) async {
    NetworkHelper http = NetworkHelper(
        '$coinApiBaseURL/$crypto/$currency?apikey=${Environment.apiKey}');

    return await http.fetchCryptoData();
  }
}
