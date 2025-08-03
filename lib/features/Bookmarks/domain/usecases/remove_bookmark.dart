import 'package:crypto_tracker_app/core/error/failure.dart';
import 'package:crypto_tracker_app/core/usecase/usecase.dart';
import 'package:crypto_tracker_app/features/Bookmarks/domain/entities/coin.dart';
import 'package:crypto_tracker_app/features/Bookmarks/domain/repositories/bookmark_repository.dart';
import 'package:dartz/dartz.dart';

class RemoveBookmark extends UseCase<Unit,Params>{

  final BookmarkRepository repository;

  RemoveBookmark({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(Params params) async {
    return await repository.removeBookmark(params.coin);
  }
}

class Params {
  final Coin coin;

  Params({required this.coin});
}