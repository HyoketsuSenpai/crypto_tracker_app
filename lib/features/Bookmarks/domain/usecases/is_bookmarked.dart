import 'package:crypto_tracker_app/core/error/failure.dart';
import 'package:crypto_tracker_app/core/usecase/usecase.dart';
import 'package:crypto_tracker_app/features/Bookmarks/domain/entities/coin.dart';
import 'package:crypto_tracker_app/features/Bookmarks/domain/repositories/bookmark_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class IsBookmarked extends UseCase<bool, Params> {
  final BookmarkRepository repository;

  IsBookmarked({required this.repository});

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await repository.isBookmarked(params.coin);
  }
}

class Params extends Equatable {
  final Coin coin;

  Params({required this.coin});

  @override
  List<Object?> get props => [coin];
}
