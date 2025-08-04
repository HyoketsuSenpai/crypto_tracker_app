import 'dart:convert';

import 'package:crypto_tracker_app/features/Bookmarks/domain/entities/coin.dart';

class CoinModel extends Coin {
  const CoinModel({
    required super.id,
    required super.symbol,
    required super.name,
    required super.image,
    required super.currentPrice,
    required super.priceChangePercentage24h,
  });

  factory CoinModel.fromJson(Map<String, dynamic> json) {
    return CoinModel(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      image: json['image'],
      currentPrice: (json['current_price'] as num).toDouble(),
      priceChangePercentage24h: (json['price_change_percentage_24h'] as num)
          .toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'symbol': symbol,
      'name': name,
      'image': image,
      'current_price': (currentPrice as num).toInt(),
      'price_change_percentage_24h': priceChangePercentage24h,
    };
  }

  static String encode(List<CoinModel> coins) => json.encode(
    coins.map<Map<String, dynamic>>((coin) => coin.toMap()).toList(),
  );

  static List<CoinModel> decode(String coins) =>
      (json.decode(coins) as List<dynamic>)
          .map<CoinModel>((coin) => CoinModel.fromJson(coin))
          .toList();
          
}
