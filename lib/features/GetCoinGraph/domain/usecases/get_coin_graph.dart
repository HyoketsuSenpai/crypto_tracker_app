import 'package:crypto_tracker_app/core/error/failure.dart';
import 'package:crypto_tracker_app/core/usecase/usecase.dart';
import 'package:crypto_tracker_app/features/GetCoinGraph/domain/entities/time_price.dart';
import 'package:crypto_tracker_app/features/GetCoinGraph/domain/repositories/coin_graph_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetCoinGraph extends UseCase<List<TimePrice>, Params> {
  final CoinGraphRepository coinGraphRepository;

  GetCoinGraph({required this.coinGraphRepository});

  @override
  Future<Either<Failure, List<TimePrice>>> call(Params params) async {
    return await coinGraphRepository.getCoinGraph(params.id, params.days);
  }
}

class Params extends Equatable {
  final String id;
  final int days;

  const Params({required this.id, required this.days});

  @override
  List<Object?> get props => [id, days];
}
