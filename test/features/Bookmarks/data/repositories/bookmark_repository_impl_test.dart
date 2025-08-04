import 'package:crypto_tracker_app/core/error/exception.dart';
import 'package:crypto_tracker_app/core/error/failure.dart';
import 'package:crypto_tracker_app/features/Bookmarks/data/datasources/bookmark_local_data_source.dart';
import 'package:crypto_tracker_app/features/Bookmarks/data/models/coin_model.dart';
import 'package:crypto_tracker_app/features/Bookmarks/data/repositories/bookmark_repository_impl.dart';
import 'package:crypto_tracker_app/features/Bookmarks/domain/repositories/bookmark_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<BookmarkLocalDataSource>()])
import 'bookmark_repository_impl_test.mocks.dart';

void main() {
  late MockBookmarkLocalDataSource localDataSource;
  late BookmarkRepositoryImpl repositoryImpl;

  setUp(() {
    localDataSource = MockBookmarkLocalDataSource();
    repositoryImpl = BookmarkRepositoryImpl(dataSource: localDataSource);
  });

  CoinModel coin = CoinModel(
    id: 'id',
    symbol: 'symbol',
    name: 'name',
    image: 'image',
    currentPrice: 1,
    priceChangePercentage24h: 1,
  );

  List<CoinModel> coins = [
    CoinModel(
      id: 'id',
      symbol: 'symbol',
      name: 'name',
      image: 'image',
      currentPrice: 1,
      priceChangePercentage24h: 1,
    ),
    CoinModel(
      id: 'id',
      symbol: 'symbol',
      name: 'name',
      image: 'image',
      currentPrice: 1,
      priceChangePercentage24h: 1,
    ),
  ];

  group('Bookmark Repo Impl', () {
    test('should be a book repo', () {
      expect(repositoryImpl, isA<BookmarkRepository>());
    });

    group('Add Bookmark', () {
      test('Should use dataSource', () async {
        when(localDataSource.addBookmark(any)).thenAnswer((_) async => unit);

        await repositoryImpl.addBookmark(coin);

        verify(localDataSource.addBookmark(coin));
      });

      test('return right unit when datasource works', () async {
        when(localDataSource.addBookmark(any)).thenAnswer((_) async => unit);

        final result = await repositoryImpl.addBookmark(coin);

        expect(result, Right(unit));
      });

      test('return left Cache failure on exception', () async {
        when(localDataSource.addBookmark(any)).thenThrow(CacheException());

        final result = await repositoryImpl.addBookmark(coin);

        expect(result, Left(CacheFailure()));
      });
    });

    group('Get All Bookmarked', () {
      test('Should use dataSource', () async {
        when(localDataSource.getAllBookmarked()).thenAnswer((_) async => coins);

        await repositoryImpl.getAllBookmarked();

        verify(localDataSource.getAllBookmarked());
      });

      test('return right list of coins when datasource works', () async {
        when(localDataSource.getAllBookmarked()).thenAnswer((_)async=>coins);

        final result = await repositoryImpl.getAllBookmarked();

        expect(result, Right(coins));
      });

      test('return left CacheFailure when datasource does not work', () async {
        when(localDataSource.getAllBookmarked()).thenThrow(CacheException());
        
        final result = await repositoryImpl.getAllBookmarked();

        expect(result, Left(CacheFailure()));

      });

    });

    group('Is Bookmarked', () {
      test('Should use the datasource', () async {
        when(localDataSource.isBookmarked(any)).thenAnswer((_)async=> true);

        await repositoryImpl.isBookmarked(coin);

        verify(localDataSource.isBookmarked(coin));
      });

      test('return right boolesn when datasource works', () async {
        when(localDataSource.isBookmarked(any)).thenAnswer((_)async=> true);

        final result = await repositoryImpl.isBookmarked(coin);

        expect(result, Right(true));
      });

      test('return left Cache Failure when datasource does not work', () async {
        when(localDataSource.isBookmarked(any)).thenThrow(CacheException());

        final result = await repositoryImpl.isBookmarked(coin);

        expect(result, Left(CacheFailure()));

      });

    });
    
    group('Remove Bookmark', () {
      test('Should use dataSource', () async {
        when(localDataSource.removeBookmark(any)).thenAnswer((_) async => unit);

        await repositoryImpl.removeBookmark(coin);

        verify(localDataSource.removeBookmark(coin));
      });

      test('return right unit when datasource works', () async {
        when(localDataSource.removeBookmark(any)).thenAnswer((_) async => unit);

        final result = await repositoryImpl.removeBookmark(coin);

        expect(result, Right(unit));
      });

      test('return left Cache failure on exception', () async {
        when(localDataSource.removeBookmark(any)).thenThrow(CacheException());

        final result = await repositoryImpl.removeBookmark(coin);

        expect(result, Left(CacheFailure()));
      });
    });
  });

}
