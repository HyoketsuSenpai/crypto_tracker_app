import 'package:crypto_tracker_app/core/error/exception.dart';
import 'package:crypto_tracker_app/core/error/failure.dart';
import 'package:crypto_tracker_app/features/GetCoinList/data/datasources/coin_list_remote_data_source.dart';
import 'package:crypto_tracker_app/features/GetCoinList/data/models/coin_model.dart';
import 'package:crypto_tracker_app/features/GetCoinList/data/repositories/coin_list_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<CoinListRemoteDataSource>()])
import 'coin_list_repository_impl_test.mocks.dart';

void main() {
  late MockCoinListRemoteDataSource mockCoinListRemoteDataSource;
  late CoinListRepositoryImpl coinListRepositoryImpl;

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
      priceChange24h: 2126.88,
      marketCap: 1381651251183,
      low24h: 68060,
      high24h: 70215,
      ath: 73738,
      atl: 67.81,
    ),
  ];

  setUp(() {
    mockCoinListRemoteDataSource = MockCoinListRemoteDataSource();
    coinListRepositoryImpl = CoinListRepositoryImpl(
      dataSource: mockCoinListRemoteDataSource,
    );
  });

  group('Get Coin List', () {
    test(
      'repo should return right list of coins when datasource works',
      () async {
        when(
          mockCoinListRemoteDataSource.getCoinList(any),
        ).thenAnswer((_) async => tCoinList);

        final result = await coinListRepositoryImpl.getCoinList(tPage);

        verify(mockCoinListRemoteDataSource.getCoinList(tPage));
        verifyNoMoreInteractions(mockCoinListRemoteDataSource);
        expect(result, Right(tCoinList));
      },
    );

    test(
      'repo should return a left Server Failure when datasource fails',
      () async {
        when(
          mockCoinListRemoteDataSource.getCoinList(any),
        ).thenThrow(ServerException());

        final result = await coinListRepositoryImpl.getCoinList(tPage);

        verify(mockCoinListRemoteDataSource.getCoinList(tPage));
        verifyNoMoreInteractions(mockCoinListRemoteDataSource);
        expect(result, Left(ServerFailure()));
      },
    );
  });

}
