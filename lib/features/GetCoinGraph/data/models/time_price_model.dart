import 'package:crypto_tracker_app/features/GetCoinGraph/domain/entities/time_price.dart';

class TimePriceModel extends TimePrice {
  const TimePriceModel({required super.time, required super.price});

  factory TimePriceModel.fromJson(List<dynamic> json) {
    return TimePriceModel(
      time: DateTime.fromMicrosecondsSinceEpoch(json[0]),
      price: json[1],
    );
  }
}
