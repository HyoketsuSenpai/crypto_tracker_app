part of 'bookmarks_bloc.dart';

abstract class BookmarksEvent extends Equatable {
  const BookmarksEvent();

  @override
  List<Object> get props => [];
}

class GetBookmarksEvent extends BookmarksEvent {}

class IsBookmarkedEvent extends BookmarksEvent {
  final Coin coin;

  IsBookmarkedEvent({required this.coin});
}

class AddBookmarkEvent extends BookmarksEvent {
  final Coin coin;

  AddBookmarkEvent({required this.coin});
}

class RemoveBookmarkEvent extends BookmarksEvent {
  final Coin coin;

  RemoveBookmarkEvent({required this.coin});
}
