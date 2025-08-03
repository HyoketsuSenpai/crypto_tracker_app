import 'package:crypto_tracker_app/core/error/failure.dart';
import 'package:crypto_tracker_app/features/Bookmarks/domain/entities/coin.dart';
import 'package:crypto_tracker_app/features/Bookmarks/domain/repositories/bookmark_repository.dart';
import 'package:crypto_tracker_app/features/Bookmarks/domain/usecases/is_bookmarked.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<BookmarkRepository>()])
import 'is_bookmarked_test.mocks.dart';

void main() {
  late MockBookmarkRepository repository;
  late IsBookmarked usecase;

  setUp(() {
    repository = MockBookmarkRepository();
    usecase = IsBookmarked(repository: repository);
  });

  Coin coin = Coin(
    id: 'id',
    symbol: 'symbol',
    name: 'name',
    image: 'image',
    currentPrice: 1,
    priceChangePercentage24h: 1,
  );

  group('Is Bookmarked', () {
    test('repo must be used', () async {
      when(repository.isBookmarked(any)).thenAnswer((_) async => Right(true));

      await usecase(Params(coin: coin));

      verify(repository.isBookmarked(coin));
    });

    test('should return right bool when repo works', () async {
      when(repository.isBookmarked(any)).thenAnswer((_) async => Right(true));

      final result = await usecase(Params(coin: coin));

      expect(result, Right(true));
    });

    test('should return left failure when repo does not works', () async {
      when(
        repository.isBookmarked(any),
      ).thenAnswer((_) async => Left(Failure()));

      final result = await usecase(Params(coin: coin));

      expect(result, Left(Failure()));
    });
  });
}
