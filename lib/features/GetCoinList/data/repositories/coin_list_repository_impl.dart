import 'package:crypto_tracker_app/core/error/exception.dart';
import 'package:crypto_tracker_app/core/error/failure.dart';
import 'package:crypto_tracker_app/features/GetCoinList/data/datasources/coin_list_remote_data_source.dart';

import 'package:crypto_tracker_app/features/GetCoinList/domain/entities/coin.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repositories/coin_list_repository.dart';

class CoinListRepositoryImpl implements CoinListRepository {
  final CoinListRemoteDataSource dataSource;

  CoinListRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<Coin>>> getCoinList(int page) async {
    try {
      return Right(await dataSource.getCoinList(page));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
