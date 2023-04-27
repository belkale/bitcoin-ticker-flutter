import 'network.dart';

const coinapi_host = 'rest.coinapi.io';
const coinapi_path = 'v1/exchangerate';
const headers = {'X-CoinAPI-Key': 'getyourownapikey'};

class CoinAPI {
  Future<double> getPrice(String coinSymbol, String currency) async {
    var url = Uri.https(coinapi_host, '$coinapi_path/$coinSymbol/$currency');
    NetworkHelper helper = NetworkHelper(url: url, headers: headers);
    dynamic data = await helper.getData();
    print(data);
    if (data == null) {
      throw 'Got empty response from coinapi';
    }
    return data['rate'];
  }
}
