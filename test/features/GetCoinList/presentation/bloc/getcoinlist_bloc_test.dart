import 'package:crypto_tracker_app/core/error/failure.dart';
import 'package:crypto_tracker_app/features/GetCoinList/domain/entities/coin.dart';
import 'package:crypto_tracker_app/features/GetCoinList/domain/usecases/get_coin_list.dart';
import 'package:crypto_tracker_app/features/GetCoinList/presentation/bloc/getcoinlist_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<GetCoinList>()])
import 'getcoinlist_bloc_test.mocks.dart';

void main() {
  late GetcoinlistBloc bloc;
  late MockGetCoinList mockGetCoinList;

  setUp(() {
    mockGetCoinList = MockGetCoinList();
    bloc = GetcoinlistBloc(getCoinList: mockGetCoinList);
  });

  test('intial state should be empty', () {
    expect(bloc.state, Empty());
  });

  group('GetCoinList', () {
    int tPage = 1;
    List<Coin> coins = [
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

    test('Should call usecase', () async {
      when(mockGetCoinList(any)).thenAnswer((_) async => Right(coins));

      bloc.add(GetCoinListEvent(tPage));
      await untilCalled(mockGetCoinList(any));

      verify(mockGetCoinList(Params(page: tPage)));
    });

    test('Should emit [Loading, Loaded] when usecase works', () async {
      when(mockGetCoinList(any)).thenAnswer((_) async => Right(coins));

      final expected = [Loading(), Loaded(coins: coins)];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(GetCoinListEvent(tPage));
    });

    test('Should emit [Loading, Error] when usecase does not work', () async {
      when(mockGetCoinList(any)).thenAnswer((_) async => Left(ServerFailure()));

      final expected = [Loading(), Error(message: 'error message')];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(GetCoinListEvent(tPage));
    });
  });
}
