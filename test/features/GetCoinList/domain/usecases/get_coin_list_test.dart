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
      id: "a",
      symbol: "b",
      name: "c",
      image: "d",
      currentPrice: 123,
      priceChangePercentage24h: 123,
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