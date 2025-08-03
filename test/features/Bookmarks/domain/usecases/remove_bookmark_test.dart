import 'package:crypto_tracker_app/core/error/failure.dart';
import 'package:crypto_tracker_app/features/Bookmarks/domain/entities/coin.dart';
import 'package:crypto_tracker_app/features/Bookmarks/domain/repositories/bookmark_repository.dart';
import 'package:crypto_tracker_app/features/Bookmarks/domain/usecases/remove_bookmark.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<BookmarkRepository>()])
import 'remove_bookmark_test.mocks.dart';

void main() {
  late MockBookmarkRepository repository;
  late RemoveBookmark usecase;

  setUp(() {
    repository = MockBookmarkRepository();
    usecase = RemoveBookmark(repository: repository);
  });

  Coin coin = Coin(
    id: 'id',
    symbol: 'symbol',
    name: 'name',
    image: 'image',
    currentPrice: 1,
    priceChangePercentage24h: 1,
  );

  group('Remove Bookmarked', () {
    test('repo must be used', () async {
      when(repository.removeBookmark(any)).thenAnswer((_) async => Right(unit));

      await usecase(Params(coin: coin));

      verify(repository.removeBookmark(coin));
    });

    test('should return right unit when repo works', () async {
      when(repository.removeBookmark(any)).thenAnswer((_) async => Right(unit));

      final result = await usecase(Params(coin: coin));

      expect(result, Right(unit));
    });

    test('should return left failure when repo does not works', () async {
      when(
        repository.removeBookmark(any),
      ).thenAnswer((_) async => Left(Failure()));

      final result = await usecase(Params(coin: coin));

      expect(result, Left(Failure()));
    });
  });
}
