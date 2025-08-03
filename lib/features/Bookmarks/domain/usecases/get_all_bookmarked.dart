import 'package:crypto_tracker_app/core/error/failure.dart';
import 'package:crypto_tracker_app/core/usecase/usecase.dart';
import 'package:crypto_tracker_app/features/Bookmarks/domain/repositories/bookmark_repository.dart';
import 'package:dartz/dartz.dart';

import '../entities/coin.dart';

class GetAllBookmarked extends UseCase<List<Coin>, NoParams>{

  final BookmarkRepository repository;

  GetAllBookmarked({required this.repository});

  @override
  Future<Either<Failure, List<Coin>>> call(NoParams params) {
    return repository.getAllBookmarked();
  }
}

