import 'package:crypto_tracker_app/features/Bookmarks/domain/entities/coin.dart';
import 'package:crypto_tracker_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Bookmarks/presentation/bloc/bookmarks_bloc.dart';

class BookmarkIcon extends StatelessWidget {
  final Coin coin;
  const BookmarkIcon({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<BookmarksBloc>()..add(IsBookmarkedEvent(coin: coin)),
      child: BlocBuilder<BookmarksBloc, BookmarksState>(
        builder: (context, state) {
          if (state is Loading) {
            return IconButton(
              icon: const Icon(Icons.question_mark),
              onPressed: () {},
            );
          }
          if (state is Bookmark) {
            final isBookmarked = state.isBookmarked;
            return IconButton(
              icon: Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_border),
              onPressed: () {
                if (isBookmarked) {
                  context.read<BookmarksBloc>().add(
                    RemoveBookmarkEvent(coin: coin),
                  );
                } else {
                  context.read<BookmarksBloc>().add(
                    AddBookmarkEvent(coin: coin),
                  );
                }
              },
            );
          }
          if (state is Error) {
            return IconButton(
              icon: const Icon(Icons.error),
              onPressed: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              },
            );
          }
          return IconButton(icon: const Icon(Icons.error), onPressed: () {});
        },
      ),
    );
  }
}
