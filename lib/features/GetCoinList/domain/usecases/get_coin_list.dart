import 'package:crypto_tracker_app/core/error/failure.dart';
import 'package:crypto_tracker_app/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../entities/coin.dart';
import '../repositories/coin_list_repository.dart';

class GetCoinList extends UseCase<List<Coin>, Params> {
  final CoinListRepository repository;

  GetCoinList({required this.repository});

  @override
  Future<Either<Failure, List<Coin>>> call(Params params) async {
    return await repository.getCoinList(params.page);
  }
}

class Params extends Equatable {
  final int page;

  const Params({required this.page});

  @override
  List<Object?> get props => [page];
}
