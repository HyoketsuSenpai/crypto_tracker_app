import 'package:crypto_tracker_app/core/error/exception.dart';
import 'package:crypto_tracker_app/features/GetCoinGraph/data/datasources/coin_graph_remote_data_source.dart';
import 'package:crypto_tracker_app/features/GetCoinGraph/data/models/time_price_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixture_reader.dart';
@GenerateNiceMocks([MockSpec<http.Client>()])
import 'coin_graph_remote_data_source_test.mocks.dart';

void main() {
  late MockClient client;
  late CoinGraphRemoteDataSourceImpl dataSourceImpl;
  late String apiKey;

  setUp(() {
    dotenv.testLoad(fileInput: 'API_KEY=test-key');

    apiKey = dotenv.env['API_KEY']!;
    client = MockClient();
    dataSourceImpl = CoinGraphRemoteDataSourceImpl(
      client: client,
      apiKey: apiKey,
    );
  });

  String tId = 'bitcoin';
  int tDays = 1;

  List<TimePriceModel> tList = [
    TimePriceModel(
      time: DateTime.fromMicrosecondsSinceEpoch(1754039970774),
      price: 115019.9640215161,
    ),
    TimePriceModel(
      time: DateTime.fromMicrosecondsSinceEpoch(1754040222780),
      price: 115128.28814686915,
    ),
  ];

  group('Coin Graph remote data source', () {
    test('client should be used with the given path', () {
      when(client.get(any)).thenAnswer(
        (_) async => http.Response(fixture('coin_graph_points.json'), 200),
      );

      dataSourceImpl.getCoinGraph(tId, tDays);

      verify(
        client.get(
          Uri.parse(
            'https://api.coingecko.com/api/v3/coins/$tId/market_chart?vs_currency=usd&days=$tDays&x_cg_demo_api_key=$apiKey',
          ),
        ),
      );
    });

    test('should return list when http request works', () async {
      when(client.get(any)).thenAnswer(
        (_) async => http.Response(fixture('coin_graph_points.json'), 200),
      );

      final result = await dataSourceImpl.getCoinGraph(tId, tDays);

      expect(result, tList);
    });

    test('should throw ServerException when http request does not works', () async {
      when(client.get(any)).thenAnswer(
        (_) async => http.Response(fixture('error'), 404),
      );

      final result = dataSourceImpl.getCoinGraph;

      expect(()=>result(tId,tDays), throwsA(TypeMatcher<ServerException>()));
    });

  });
}
