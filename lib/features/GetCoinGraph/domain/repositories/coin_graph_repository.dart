import 'package:crypto_tracker_app/core/error/failure.dart';
import 'package:crypto_tracker_app/features/GetCoinGraph/domain/entities/time_price.dart';
import 'package:dartz/dartz.dart';

abstract class CoinGraphRepository {
  Future<Either<Failure, List<TimePrice>>> getCoinGraph(String id, int days);  
}