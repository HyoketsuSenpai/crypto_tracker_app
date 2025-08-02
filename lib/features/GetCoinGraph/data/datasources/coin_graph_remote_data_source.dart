import 'dart:convert';

import 'package:crypto_tracker_app/core/error/exception.dart';
import 'package:crypto_tracker_app/features/GetCoinGraph/data/models/time_price_model.dart';
import 'package:http/http.dart' as http;

abstract class CoinGraphRemoteDataSource {
  /// Calls the https://api.coingecko.com/api/v3/coins/{id}/market_chart?vs_currency=usd&days={days}&x_cg_demo_api_key={API_KEY}
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<TimePriceModel>> getCoinGraph(String id, int days);
}

class CoinGraphRemoteDataSourceImpl extends CoinGraphRemoteDataSource {
  final http.Client client;
  final String apiKey;

  CoinGraphRemoteDataSourceImpl({required this.client, required this.apiKey});

  @override
  Future<List<TimePriceModel>> getCoinGraph(String id, int days) async {
    try {
      final response = await client.get(
        Uri.parse(
          'https://api.coingecko.com/api/v3/coins/$id/market_chart?vs_currency=usd&days=$days&x_cg_demo_api_key=$apiKey',
        ),
      );
      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body) as Map<String, dynamic>;
        final jsonList = jsonMap['prices'] as List<dynamic>;
        return jsonList
            .map((json) => TimePriceModel.fromJson(json as List<dynamic>))
            .toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
