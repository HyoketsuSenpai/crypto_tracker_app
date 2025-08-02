import 'package:crypto_tracker_app/core/error/exception.dart';
import 'package:crypto_tracker_app/core/error/failure.dart';
import 'package:crypto_tracker_app/features/GetCoinGraph/data/datasources/coin_graph_remote_data_source.dart';
import 'package:crypto_tracker_app/features/GetCoinGraph/data/models/time_price_model.dart';
import 'package:crypto_tracker_app/features/GetCoinGraph/domain/repositories/coin_graph_repository.dart';
import 'package:dartz/dartz.dart';

class CoinGraphRepositoryImpl implements CoinGraphRepository {
  final CoinGraphRemoteDataSource dataSource;

  CoinGraphRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<TimePriceModel>>> getCoinGraph(
    String id,
    int days,
  ) async {
    try {
      return Right(await dataSource.getCoinGraph(id, days));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
