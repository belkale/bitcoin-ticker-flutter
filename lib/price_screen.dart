import 'package:bitcoin_ticker/services/coinapi.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';
import 'components/price-card.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  List<CryptoPrice> priceList = cryptoList
      .map<CryptoPrice>((String ticker) =>
          CryptoPrice(crypto: ticker, currency: 'USD', price: '??'))
      .toList();
  List<Widget> priceWidgets = [];

  @override
  void initState() {
    super.initState();
    updateUI();
  }

  void updateUI() async {
    CoinAPI api = CoinAPI();
    for (CryptoPrice cp in priceList) {
      double price = await api.getPrice(cp.crypto, selectedCurrency);
      cp.currency = selectedCurrency;
      cp.price = price.toStringAsFixed(2);
    }
    setState(() {
      priceWidgets = getPriceWidgets();
    });
  }

  List<Widget> getPriceWidgets() {
    List<Widget> children = [];

    for (CryptoPrice cp in priceList) {
      children.add(PriceCard(
          crypto: cp.crypto,
          cryptoPrice: cp.price,
          selectedCurrency: cp.currency));
    }
    return children;
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
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: priceWidgets,
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
              value: selectedCurrency,
              onChanged: (value) {
                selectedCurrency = value;
                updateUI();
              },
              items: currenciesList
                  .map<DropdownMenuItem<String>>(
                    (String value) => DropdownMenuItem<String>(
                      child: Text(value),
                      value: value,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
