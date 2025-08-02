import 'package:bloc/bloc.dart';
import 'package:crypto_tracker_app/features/GetCoinList/domain/entities/coin.dart';
import 'package:crypto_tracker_app/features/GetCoinList/domain/usecases/get_coin_list.dart';
import 'package:equatable/equatable.dart';

part 'getcoinlist_event.dart';
part 'getcoinlist_state.dart';

class GetcoinlistBloc extends Bloc<GetcoinlistEvent, GetcoinlistState> {

  final GetCoinList getCoinList;
  GetcoinlistBloc({required this.getCoinList}) : super(Empty()) {
    on<GetCoinListEvent>((event, emit) async {
      emit(Loading());
      final result = await getCoinList(Params(page: event.page));
     result.fold(
        (failure) {
          emit(Error(message: 'error message'));
        },
        (coins) {
          emit(Loaded(coins: coins));
        },
      );

      

    });
  }
}
