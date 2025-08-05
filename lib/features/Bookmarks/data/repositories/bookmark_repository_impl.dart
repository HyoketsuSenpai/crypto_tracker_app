import 'package:crypto_tracker_app/core/error/exception.dart';
import 'package:crypto_tracker_app/core/error/failure.dart';
import 'package:crypto_tracker_app/features/Bookmarks/data/datasources/bookmark_local_data_source.dart';
import 'package:crypto_tracker_app/features/Bookmarks/data/models/coin_model.dart';
import 'package:crypto_tracker_app/features/Bookmarks/domain/entities/coin.dart';
import 'package:crypto_tracker_app/features/Bookmarks/domain/repositories/bookmark_repository.dart';
import 'package:dartz/dartz.dart';

class BookmarkRepositoryImpl implements BookmarkRepository {
  final BookmarkLocalDataSource dataSource;

  BookmarkRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, Unit>> addBookmark(Coin coin) async {
    try {
      return Right(await dataSource.addBookmark(CoinModel.fromEntity(coin)));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<CoinModel>>> getAllBookmarked() async {
    try {
      return Right(await dataSource.getAllBookmarked());
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isBookmarked(Coin coin) async {
    try {
      return Right(await dataSource.isBookmarked(CoinModel.fromEntity(coin)));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> removeBookmark(Coin coin) async {
    try {
      return Right(await dataSource.removeBookmark(CoinModel.fromEntity(coin)));
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
