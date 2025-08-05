import 'package:crypto_tracker_app/features/GetCoinList/domain/entities/coin.dart';

class CoinModel extends Coin {
  const CoinModel({
    required super.id,
    required super.symbol,
    required super.name,
    required super.image,
    required super.currentPrice,
    required super.priceChangePercentage24h,
    required super.priceChange24h,
    required super.marketCap,
    required super.low24h,
    required super.high24h,
    required super.ath,
    required super.atl,
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
      priceChange24h: (json['price_change_24h'] as num).toDouble(),
      marketCap: (json['market_cap'] as num).toInt(),
      low24h: (json['low_24h'] as num).toInt(),
      high24h: (json['high_24h'] as num).toInt(),
      ath: (json['ath'] as num).toInt(),
      atl: (json['atl'] as num).toDouble(),
    );
  }
}
