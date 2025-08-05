import 'package:bloc/bloc.dart';
import 'package:crypto_tracker_app/core/usecase/usecase.dart';
import 'package:crypto_tracker_app/features/Bookmarks/domain/entities/coin.dart';
import 'package:crypto_tracker_app/features/Bookmarks/domain/usecases/add_bookmark.dart'
    as add_bookmark;
import 'package:crypto_tracker_app/features/Bookmarks/domain/usecases/get_all_bookmarked.dart';
import 'package:crypto_tracker_app/features/Bookmarks/domain/usecases/is_bookmarked.dart';
import 'package:crypto_tracker_app/features/Bookmarks/domain/usecases/remove_bookmark.dart'
    as remove_bookmark;
import 'package:equatable/equatable.dart';

part 'bookmarks_event.dart';
part 'bookmarks_state.dart';

class BookmarksBloc extends Bloc<BookmarksEvent, BookmarksState> {
  final add_bookmark.AddBookmark addBookmark;
  final GetAllBookmarked getAllBookmarked;
  final IsBookmarked isBookmarked;
  final remove_bookmark.RemoveBookmark removeBookmark;

  BookmarksBloc(
    this.addBookmark,
    this.getAllBookmarked,
    this.isBookmarked,
    this.removeBookmark,
  ) : super(Empty()) {
    on<AddBookmarkEvent>((event, emit) async {
      final result = await addBookmark(add_bookmark.Params(coin: event.coin));
      result.fold(
        (error) => emit(Error(message: 'Error message')),
        (success) => emit(Bookmark(isBookmarked: true)),
      );
    });

    on<GetBookmarksEvent>((event, emit) async {
      final result = await getAllBookmarked(NoParams());
      result.fold(
        (error) => emit(Error(message: 'Error message')),
        (coins) => emit(BookmarkList(coins: coins)),
      );
    });

    on<IsBookmarkedEvent>((event, emit) async {
      final result = await isBookmarked(Params(coin: event.coin));
      result.fold(
        (error) => emit(Error(message: 'Error message')),
        (isBookmarked) => emit(Bookmark(isBookmarked: isBookmarked)),
      );
    });

    on<RemoveBookmarkEvent>((event, emit) async {
      final result = await removeBookmark(
        remove_bookmark.Params(coin: event.coin),
      );
      result.fold(
        (error) => emit(Error(message: 'Error message')),
        (success) => emit(Bookmark(isBookmarked: false)),
      );
    });
  }
}
