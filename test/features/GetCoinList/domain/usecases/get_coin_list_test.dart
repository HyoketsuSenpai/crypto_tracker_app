import 'package:crypto_tracker_app/features/GetCoinList/domain/entities/coin.dart';
import 'package:crypto_tracker_app/features/GetCoinList/domain/repositories/coin_list_repository.dart';
import 'package:crypto_tracker_app/features/GetCoinList/domain/usecases/get_coin_list.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<CoinListRepository>()])
import 'get_coin_list_test.mocks.dart';

//TODO: Shouldn't we have a test for failure too? Like when a Left is returned

void main() {
  late MockCoinListRepository mockCoinListRepository;
  late GetCoinList getCoinList;

  setUp(() {
    mockCoinListRepository = MockCoinListRepository();
    getCoinList = GetCoinList(repository: mockCoinListRepository);
  });

  final int tPage = 1;
  final List<Coin> tCoinList = [
    Coin(
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

  test('Should get list of coins from repository', () async {
    when(
      mockCoinListRepository.getCoinList(any),
    ).thenAnswer((_) async => Right(tCoinList));

    final result = await getCoinList(Params(page: tPage));

    expect(result, Right(tCoinList));
    verify(mockCoinListRepository.getCoinList(tPage));
    verifyNoMoreInteractions(mockCoinListRepository);

  });
}