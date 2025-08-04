import 'package:crypto_tracker_app/core/error/exception.dart';
import 'package:crypto_tracker_app/features/Bookmarks/data/datasources/bookmark_local_data_source.dart';
import 'package:crypto_tracker_app/features/Bookmarks/data/models/coin_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixture_reader.dart';
@GenerateNiceMocks([MockSpec<SharedPreferences>()])
import 'bookmark_local_data_source_test.mocks.dart';

void main() {
  late MockSharedPreferences mockSP;
  late BookmarkLocalDataSourceImpl dataSourceImpl;

  setUp(() {
    mockSP = MockSharedPreferences();
    dataSourceImpl = BookmarkLocalDataSourceImpl(sp: mockSP);
  });

  CoinModel coin = CoinModel(
    id: "bitcoin",
    symbol: "btc",
    name: "Bitcoin",
    image:
        "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
    currentPrice: 70187,
    priceChangePercentage24h: 3.12502,
  );

  List<CoinModel> coins = [
    CoinModel(
      id: "bitcoin",
      symbol: "btc",
      name: "Bitcoin",
      image:
          "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
      currentPrice: 70187,
      priceChangePercentage24h: 3.12502,
    ),
    CoinModel(
      id: "bitcoin",
      symbol: "btc",
      name: "Bitcoin",
      image:
          "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
      currentPrice: 70187,
      priceChangePercentage24h: 3.12502,
    ),
  ];

  List<CoinModel> coinsPlusOne = [
    ...coins,
    CoinModel(
      id: "bitcoin",
      symbol: "btc",
      name: "Bitcoin",
      image:
          "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
      currentPrice: 70187,
      priceChangePercentage24h: 3.12502,
    ),
  ];

  List<CoinModel> coinsMinusOne = [
    CoinModel(
      id: "bitcoin",
      symbol: "btc",
      name: "Bitcoin",
      image:
          "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
      currentPrice: 70187,
      priceChangePercentage24h: 3.12502,
    ),
  ];

  group('Bookmark local data source implementation', () {
    test('gotta be a bookmark local datasource', () {
      expect(dataSourceImpl, isA<BookmarkLocalDataSource>());
    });

    group('Add Bookmark', () {
      test('Gotta use shared preferences', () async {
        final coinsJson = fixture('coins_short.json');
        when(mockSP.getString(any)).thenReturn(coinsJson);

        when(mockSP.setString(any, any)).thenAnswer((_) async => true);

        await dataSourceImpl.addBookmark(coin);

        verifyInOrder([
          mockSP.getString('bookmark'),
          mockSP.setString('bookmark', CoinModel.encode(coinsPlusOne)),
        ]);
      });
      test('should return a unit when shared preference works', () async {
        final coinsJson = fixture('coins_short.json');
        when(mockSP.getString(any)).thenReturn(coinsJson);

        when(mockSP.setString(any, any)).thenAnswer((_) async => true);

        final result = await dataSourceImpl.addBookmark(coin);

        expect(result, unit);
      });

      test(
        'should throw a Cache exception when shared preference does not work',
        () async {
          final coinsJson = fixture('coins_short.json');
          when(mockSP.getString(any)).thenThrow(Exception());

          when(mockSP.setString(any, any)).thenAnswer((_) async => false);

          final result = dataSourceImpl.addBookmark;

          expect(() => result(coin), throwsA(isA<CacheException>()));
        },
      );
    });

    group('Get All Bookmarked', () {
      test('Gotta use shared preferences', () async {
        final coinsJson = fixture('coins_short.json');
        when(mockSP.getString(any)).thenReturn(coinsJson);

        await dataSourceImpl.getAllBookmarked();

        verify(mockSP.getString('bookmark'));
      });

      test('Should return list of coins from cache', () async {
        final coinsJson = fixture('coins_short.json');
        when(mockSP.getString(any)).thenReturn(coinsJson);

        final result = await dataSourceImpl.getAllBookmarked();

        expect(result, coins);
      });
    });

    group('Remove Bookmark', () {
      test('Gotta use shared preferences', () async {
        final coinsJson = fixture('coins_short.json');
        when(mockSP.getString(any)).thenReturn(coinsJson);

        when(mockSP.setString(any, any)).thenAnswer((_) async => true);

        await dataSourceImpl.removeBookmark(coin);

        verifyInOrder([
          mockSP.getString('bookmark'),
          mockSP.setString('bookmark', CoinModel.encode(coinsMinusOne)),
        ]);
      });

      test('should return a unit when shared preference works', () async {
        final coinsJson = fixture('coins_short.json');
        when(mockSP.getString(any)).thenReturn(coinsJson);

        when(mockSP.setString(any, any)).thenAnswer((_) async => true);

        final result = await dataSourceImpl.removeBookmark(coin);

        expect(result, unit);
      });

      test(
        'should throw a Cache exception when shared preference does not work',
        () async {
          when(mockSP.getString(any)).thenThrow(Exception());

          when(mockSP.setString(any, any)).thenAnswer((_) async => false);

          final result = dataSourceImpl.removeBookmark;

          expect(() => result(coin), throwsA(isA<CacheException>()));
        },
      );
    });

    group('Is Bookmarked', () {
      test('Gotta use shared preferences', () async {
        final coinsJson = fixture('coins_short.json');
        when(mockSP.getString(any)).thenReturn(coinsJson);

        await dataSourceImpl.isBookmarked(coin);

        verify(mockSP.getString('bookmark'));
      });

      test('Return a bool', () async {
        final coinsJson = fixture('coins_short.json');
        when(mockSP.getString(any)).thenReturn(coinsJson);

        final result = await dataSourceImpl.isBookmarked(coin);

        expect(result, isA<bool>());
      });
    });


  });
}


// I consider the tests done here indufficient tbh