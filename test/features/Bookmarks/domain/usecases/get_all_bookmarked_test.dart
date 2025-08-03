import 'package:crypto_tracker_app/core/error/failure.dart';
import 'package:crypto_tracker_app/core/usecase/usecase.dart';
import 'package:crypto_tracker_app/features/Bookmarks/domain/entities/coin.dart';
import 'package:crypto_tracker_app/features/Bookmarks/domain/repositories/bookmark_repository.dart';
import 'package:crypto_tracker_app/features/Bookmarks/domain/usecases/get_all_bookmarked.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<BookmarkRepository>()])
import 'get_all_bookmarked_test.mocks.dart';

void main() {
  late MockBookmarkRepository repository;
  late GetAllBookmarked usecase;

  setUp(() {
    repository = MockBookmarkRepository();
    usecase = GetAllBookmarked(repository: repository);
  });

  List<Coin> coins = [
    Coin(
    id: 'id',
    symbol: 'symbol',
    name: 'name',
    image: 'image',
    currentPrice: 1,
    priceChangePercentage24h: 1,
  ),
  Coin(
    id: 'id',
    symbol: 'symbol',
    name: 'name',
    image: 'image',
    currentPrice: 1,
    priceChangePercentage24h: 1,
  )
  ];

  group('Get All Bookmarked', () {
    test('repo must be used', () async {
      when(repository.getAllBookmarked()).thenAnswer((_) async => Right(coins));

      await usecase(NoParams());

      verify(repository.getAllBookmarked());
    });

    test('should return right unit when repo works', () async {
      when(repository.getAllBookmarked()).thenAnswer((_) async => Right(coins));

      final result = await usecase(NoParams());

      expect(result, Right(coins));
    });

    test('should return left failure when repo does not works', () async {
      when(
        repository.getAllBookmarked(),
      ).thenAnswer((_) async => Left(Failure()));

      final result = await usecase(NoParams());

      expect(result, Left(Failure()));
    });
  });
}
