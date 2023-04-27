import 'package:flutter/material.dart';

class PriceCard extends StatelessWidget {
  const PriceCard({
    Key key,
    @required this.crypto,
    @required this.cryptoPrice,
    @required this.selectedCurrency,
  }) : super(key: key);

  final String crypto;
  final String cryptoPrice;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $crypto = $cryptoPrice $selectedCurrency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
