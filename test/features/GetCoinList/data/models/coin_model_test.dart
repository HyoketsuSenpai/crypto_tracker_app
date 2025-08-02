import 'dart:convert';

import 'package:crypto_tracker_app/features/GetCoinList/data/models/coin_model.dart';
import 'package:crypto_tracker_app/features/GetCoinList/domain/entities/coin.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixture_reader.dart';

void main() {
  CoinModel coinModel = CoinModel(
    id: 'bitcoin',
    symbol: 'btc',
    name: 'Bitcoin',
    image: 'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400',
    currentPrice: 70187,
    priceChangePercentage24h: 3.12502,
  );

  test('coin model should be subclass of coin', () async {
    expect(coinModel, isA<Coin>());
  });

  test('fromJson should return a model from json', (){

    Map<String,dynamic> jsonMap = json.decode(fixture('coin.json'));

    CoinModel result = CoinModel.fromJson(jsonMap);

    expect(result, coinModel);
  });
}
