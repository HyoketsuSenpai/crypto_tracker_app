import 'package:bloc/bloc.dart';
import 'package:crypto_tracker_app/features/GetCoinGraph/domain/entities/time_price.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/get_coin_graph.dart';

part 'getcoingraph_event.dart';
part 'getcoingraph_state.dart';

class GetcoingraphBloc extends Bloc<GetcoingraphEvent, GetcoingraphState> {
  final GetCoinGraph getCoinGraph;

  GetcoingraphBloc(this.getCoinGraph) : super(Empty()) {
    on<GetCoinGraphEvent>((event, emit) async {
      
      emit(Loading());

      final result = await getCoinGraph(Params(id: event.id, days: event.days));
      result.fold(
        (failure) => emit(Error(message: 'error message')),
        (points) => emit(Loaded(points: points)),
      );

    });
  }
}
