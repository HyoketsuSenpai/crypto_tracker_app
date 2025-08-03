import 'dart:convert';

import 'package:crypto_tracker_app/core/error/exception.dart';
import 'package:crypto_tracker_app/features/GetCoinList/data/models/coin_model.dart';
import 'package:http/http.dart' as http;

abstract class CoinListRemoteDataSource {
  /// Calls the https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&per_page=20&page={page}&x_cg_demo_api_key={API_KEY}
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<CoinModel>> getCoinList(int page);
}

class CoinListRemoteDataSourceImpl extends CoinListRemoteDataSource {
  final http.Client client;
  final String apiKey;

  CoinListRemoteDataSourceImpl({required this.client, required this.apiKey});

  @override
  Future<List<CoinModel>> getCoinList(int page) async {
    final response = await client.get(
      Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&per_page=20&page=$page&x_cg_demo_api_key=$apiKey',
      ),
    );
    try {
      if (response.statusCode == 200) {
        final jsonList = json.decode(response.body) as List<dynamic>;
        return jsonList
            .map((json) => CoinModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
