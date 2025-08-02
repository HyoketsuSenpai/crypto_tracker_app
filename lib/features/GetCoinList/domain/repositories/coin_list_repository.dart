import 'package:crypto_tracker_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/coin.dart';

abstract class CoinListRepository {
 Future<Either<Failure, List<Coin>>> getCoinList(int page); 
}