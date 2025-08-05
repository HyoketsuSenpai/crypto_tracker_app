part of 'bookmarks_bloc.dart';

abstract class BookmarksState extends Equatable {
  final List<Object> p;

  const BookmarksState([this.p = const <Object>[]]);

  @override
  List<Object> get props => p;
}

class Empty extends BookmarksState {}

class Loading extends BookmarksState {}

class Bookmark extends BookmarksState {
  final bool isBookmarked;

  Bookmark({required this.isBookmarked}) : super([isBookmarked]);
}

class BookmarkList extends BookmarksState {
  final List<Coin> coins;

  BookmarkList({required this.coins}) : super([coins]);
}

class Error extends BookmarksState {
  final String message;

  Error({required this.message}) : super([message]);
}
