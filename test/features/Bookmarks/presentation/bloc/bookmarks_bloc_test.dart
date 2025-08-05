import 'package:crypto_tracker_app/core/error/failure.dart';
import 'package:crypto_tracker_app/core/usecase/usecase.dart';
import 'package:crypto_tracker_app/features/Bookmarks/domain/entities/coin.dart';
import 'package:crypto_tracker_app/features/Bookmarks/domain/usecases/add_bookmark.dart'
    as add_bookmark;
import 'package:crypto_tracker_app/features/Bookmarks/domain/usecases/get_all_bookmarked.dart'
    as get_all_bookmarked;
import 'package:crypto_tracker_app/features/Bookmarks/domain/usecases/is_bookmarked.dart'
    as is_bookmarked;
import 'package:crypto_tracker_app/features/Bookmarks/domain/usecases/remove_bookmark.dart'
    as remove_bookmark;
import 'package:crypto_tracker_app/features/Bookmarks/presentation/bloc/bookmarks_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<add_bookmark.AddBookmark>(),
  MockSpec<get_all_bookmarked.GetAllBookmarked>(),
  MockSpec<is_bookmarked.IsBookmarked>(),
  MockSpec<remove_bookmark.RemoveBookmark>(),
])
import 'bookmarks_bloc_test.mocks.dart';

void main() {
  late MockAddBookmark mockAddBookmark;
  late MockGetAllBookmarked mockGetAllBookmarked;
  late MockIsBookmarked mockIsBookmarked;
  late MockRemoveBookmark mockRemoveBookmark;
  late BookmarksBloc bloc;

  setUp(() {
    mockAddBookmark = MockAddBookmark();
    mockGetAllBookmarked = MockGetAllBookmarked();
    mockIsBookmarked = MockIsBookmarked();
    mockRemoveBookmark = MockRemoveBookmark();

    bloc = BookmarksBloc(
      mockAddBookmark,
      mockGetAllBookmarked,
      mockIsBookmarked,
      mockRemoveBookmark,
    );
  });

  Coin coin = Coin(
    id: 'id',
    symbol: 'symbol',
    name: 'name',
    image: 'image',
    currentPrice: 1,
    priceChangePercentage24h: 1,
  );

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
    ),
  ];

  group('Bookmarks Bloc', () {
    test('intial should be [Empty]', () {
      expect(bloc.state, Empty());
    });

    //should use usecase, on success emit xyz, on failure emit xyz
    group('Add Bookmark', () {
      test('Should use the usecase', () async {
        when(mockAddBookmark(any)).thenAnswer((_) async => Right(unit));

        bloc.add(AddBookmarkEvent(coin: coin));

        await untilCalled(mockAddBookmark(any));

        verify(mockAddBookmark(add_bookmark.Params(coin: coin)));
      });

      test('Should emit [Bookmark] when usecase works', () {
        when(mockAddBookmark(any)).thenAnswer((_) async => Right(unit));

        final expected = [Bookmark(isBookmarked: true)];

        expectLater(bloc.stream, emitsInOrder(expected));

        bloc.add(AddBookmarkEvent(coin: coin));
      });

      test('Should emit [Error] when usecase does not works', () {
        when(
          mockAddBookmark(any),
        ).thenAnswer((_) async => Left(CacheFailure()));

        final expected = [Error(message: "Error message")];

        expectLater(bloc.stream, emitsInOrder(expected));

        bloc.add(AddBookmarkEvent(coin: coin));
      });
    });

    group('Get Bookmarks', () {
      test('Should use the usecase', () async {
        when(mockGetAllBookmarked(any)).thenAnswer((_) async => Right(coins));

        bloc.add(GetBookmarksEvent());

        await untilCalled(mockGetAllBookmarked(any));

        verify(mockGetAllBookmarked(NoParams()));
      });

      test('Should emit [BookmarkList] when usecase works', () {
        when(mockGetAllBookmarked(any)).thenAnswer((_) async => Right(coins));

        final expected = [BookmarkList(coins: coins)];

        expectLater(bloc.stream, emitsInOrder(expected));

        bloc.add(GetBookmarksEvent());
      });

      test('Should emit [Error] when usecase does not works', () {
        when(
          mockGetAllBookmarked(any),
        ).thenAnswer((_) async => Left(CacheFailure()));

        final expected = [Error(message: "Error message")];

        expectLater(bloc.stream, emitsInOrder(expected));

        bloc.add(GetBookmarksEvent());
      });
    });

    group('Is Bookmarked', () {
      test('Should use the usecase', () async {
        when(mockIsBookmarked(any)).thenAnswer((_) async => Right(true));

        bloc.add(IsBookmarkedEvent(coin: coin));

        await untilCalled(mockIsBookmarked(any));

        verify(mockIsBookmarked(is_bookmarked.Params(coin: coin)));
      });

      test('Should emit [Bookmark] when usecase works', () {
        when(mockIsBookmarked(any)).thenAnswer((_) async => Right(true));

        final expected = [Bookmark(isBookmarked: true)];

        expectLater(bloc.stream, emitsInOrder(expected));

        bloc.add(IsBookmarkedEvent(coin: coin));
      });

      test('Should emit [Error] when usecase does not works', () {
        when(
          mockIsBookmarked(any),
        ).thenAnswer((_) async => Left(CacheFailure()));

        final expected = [Error(message: "Error message")];

        expectLater(bloc.stream, emitsInOrder(expected));

        bloc.add(IsBookmarkedEvent(coin: coin));
      });
    });

    group('Remove Bookmark', () {
      test('Should use the usecase', () async {
        when(mockRemoveBookmark(any)).thenAnswer((_) async => Right(unit));

        bloc.add(RemoveBookmarkEvent(coin: coin));

        await untilCalled(mockRemoveBookmark(any));

        verify(mockRemoveBookmark(remove_bookmark.Params(coin: coin)));
      });

      test('Should emit [Bookmark] when usecase works', () {
        when(mockRemoveBookmark(any)).thenAnswer((_) async => Right(unit));

        final expected = [Bookmark(isBookmarked: false)];

        expectLater(bloc.stream, emitsInOrder(expected));

        bloc.add(RemoveBookmarkEvent(coin: coin));
      });

      test('Should emit [Error] when usecase does not works', () {
        when(
          mockRemoveBookmark(any),
        ).thenAnswer((_) async => Left(CacheFailure()));

        final expected = [Error(message: "Error message")];

        expectLater(bloc.stream, emitsInOrder(expected));

        bloc.add(RemoveBookmarkEvent(coin: coin));
      });
    });
  });
}
