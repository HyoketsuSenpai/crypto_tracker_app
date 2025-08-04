import 'dart:convert';

import 'package:crypto_tracker_app/features/Bookmarks/data/models/coin_model.dart';
import 'package:crypto_tracker_app/features/Bookmarks/domain/entities/coin.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixture_reader.dart';

void main() {
  CoinModel coinModel = CoinModel(
    id: 'bitcoin',
    symbol: 'btc',
    name: 'Bitcoin',
    image:
        'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400',
    currentPrice: 70187,
    priceChangePercentage24h: 3.12502,
  );

  List<CoinModel> coins = [
    CoinModel(
      id: 'bitcoin',
      symbol: 'btc',
      name: 'Bitcoin',
      image:
          'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400',
      currentPrice: 70187,
      priceChangePercentage24h: 3.12502,
    ),
    CoinModel(
      id: 'bitcoin',
      symbol: 'btc',
      name: 'Bitcoin',
      image:
          'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400',
      currentPrice: 70187,
      priceChangePercentage24h: 3.12502,
    ),
  ];

  group('Coin Model', () {
    test('model should be a coin', () {
      expect(coinModel, isA<Coin>());
    });

    test('fromJson should return a model from json', () {
      Map<String, dynamic> jsonMap = json.decode(fixture('coin.json'));

      CoinModel result = CoinModel.fromJson(jsonMap);

      expect(result, coinModel);
    });

    test('toMap should return a jsonMap from model', () {
      Map<String, dynamic> jsonMap = json.decode(fixture('coin_short.json'));

      Map<String, dynamic> result = coinModel.toMap();

      expect(result, jsonMap);
    });

    test('encode the list', () {
      //decode then encode so that we handle newlines and such
      final jsonData = json.encode(json.decode(fixture('coins_short.json')));

      final result = CoinModel.encode(coins);

      expect(result, jsonData);
    });

    test('decode the list', () {
      final result = CoinModel.decode(fixture('coins_short.json'));

      expect(result, coins);
    });
  });
}
