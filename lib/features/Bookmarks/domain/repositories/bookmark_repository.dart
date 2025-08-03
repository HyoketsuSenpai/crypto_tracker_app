import 'package:crypto_tracker_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/coin.dart';

abstract class BookmarkRepository {

  Future<Either<Failure,Unit>> addBookmark(Coin coin);
  Future<Either<Failure, List<Coin>>> getAllBookmarked();
  Future<Either<Failure, bool>> isBookmarked(Coin coin);
  Future<Either<Failure, Unit>> removeBookmark(Coin coin);

}