import 'package:equatable/equatable.dart';

class Coin extends Equatable {
  final String id;
  final String symbol;
  final String name;
  final String image;
  final double currentPrice;
  final double priceChangePercentage24h;
  
  final double priceChange24h;
  final int marketCap;
  final int low24h;
  final int high24h;
  final int ath;
  final double atl;


  const Coin({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.priceChangePercentage24h,

    required this.priceChange24h,
    required this.marketCap,
    required this.low24h,
    required this.high24h,
    required this.ath,
    required this.atl,
  });

  @override
  List<Object?> get props => [
    id,
    symbol,
    name,
    image,
    currentPrice,
    priceChangePercentage24h,
    priceChange24h,
    marketCap,
    low24h,
    high24h,
    ath,
    atl,
  ];
}
