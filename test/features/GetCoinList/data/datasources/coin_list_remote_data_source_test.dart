import 'package:crypto_tracker_app/core/constants.dart';
import 'package:crypto_tracker_app/core/error/exception.dart';
import 'package:crypto_tracker_app/features/GetCoinList/data/datasources/coin_list_remote_data_source.dart';
import 'package:crypto_tracker_app/features/GetCoinList/data/models/coin_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixture_reader.dart';
@GenerateNiceMocks([MockSpec<http.Client>()])
import 'coin_list_remote_data_source_test.mocks.dart';

void main() async {
  late MockClient mockClient;
  late CoinListRemoteDataSourceImpl remoteDataSource;

  setUp(() {
    mockClient = MockClient();
    remoteDataSource = CoinListRemoteDataSourceImpl(client: mockClient);
  });

  int tPage = 1;
  final List<CoinModel> tCoinList = [
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

  //maybe mock the env too?
  group('Coin list Remote Data Source', () {
    test('Should call get method from client', () async {
      when(
        mockClient.get(any),
      ).thenAnswer((_) async => http.Response(fixture('coins.json'), 200));

      await remoteDataSource.getCoinList(tPage);

      verify(
        mockClient.get(
          Uri.parse(
            'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&per_page=20&page=$tPage&x_cg_demo_api_key=$apiKey',
          ),
        ),
      );
    });

    test('Should return a list of coins of http request works', () async {
      when(
        mockClient.get(any),
      ).thenAnswer((_) async => http.Response(fixture('coins.json'), 200));

      final result = await remoteDataSource.getCoinList(tPage);

      expect(result, tCoinList);
    });

    test(
      'Should throw ServerException when http request doesn\'t works',
      () async {
        when(
          mockClient.get(any),
        ).thenAnswer((_) async => http.Response('error error', 404));

        final call = remoteDataSource.getCoinList;

        expect(() => call(tPage), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
