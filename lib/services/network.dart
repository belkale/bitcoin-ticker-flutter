import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  final Uri url;
  final Map<String, String> headers;
  NetworkHelper({this.url, this.headers});

  dynamic getData() async {
    var result = await http.get(url, headers: headers);
    if (result.statusCode == 200) {
      return jsonDecode(result.body);
    } else {
      throw 'HTTP Get failed with status code ${result.statusCode}';
    }
  }
}
