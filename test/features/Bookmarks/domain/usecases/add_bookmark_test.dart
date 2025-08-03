import 'package:crypto_tracker_app/core/error/failure.dart';
import 'package:crypto_tracker_app/features/Bookmarks/domain/entities/coin.dart';
import 'package:crypto_tracker_app/features/Bookmarks/domain/repositories/bookmark_repository.dart';
import 'package:crypto_tracker_app/features/Bookmarks/domain/usecases/add_bookmark.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<BookmarkRepository>()])
import 'add_bookmark_test.mocks.dart';

void main() {
  late MockBookmarkRepository repository;
  late AddBookmark usecase;

  setUp(() {
    repository = MockBookmarkRepository();
    usecase = AddBookmark(repository: repository);
  });

  Coin coin = Coin(
    id: 'id',
    symbol: 'symbol',
    name: 'name',
    image: 'image',
    currentPrice: 1,
    priceChangePercentage24h: 1,
  );

  group('Add Bookmark', () {

    test('repo must be used', () async{
      when(repository.addBookmark(any)).thenAnswer((_) async => Right(unit));

      await usecase(Params(coin: coin));
      
      verify(repository.addBookmark(coin));
    });

    
    test('should return right unit when repo works', () async {
      when(repository.addBookmark(any)).thenAnswer((_) async => Right(unit));

      final result = await usecase(Params(coin: coin));

      expect(result, Right(unit));
    });

      test('should return left failure when repo does not works', () async {
      when(repository.addBookmark(any)).thenAnswer((_) async => Left(Failure()));

      final result = await usecase(Params(coin: coin));

      expect(result, Left(Failure()));
    });
  
  });
}
