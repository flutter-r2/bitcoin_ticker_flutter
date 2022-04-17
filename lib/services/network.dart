import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future<dynamic> fetchCryptoData() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) print(response.statusCode);

    return jsonDecode(response.body);
  }
}
