import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'getcoingraph_event.dart';
part 'getcoingraph_state.dart';

class GetcoingraphBloc extends Bloc<GetcoingraphEvent, GetcoingraphState> {
  GetcoingraphBloc() : super(GetcoingraphInitial()) {
    on<GetcoingraphEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
