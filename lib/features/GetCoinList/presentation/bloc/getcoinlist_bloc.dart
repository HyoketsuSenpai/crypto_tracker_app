import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'getcoinlist_event.dart';
part 'getcoinlist_state.dart';

class GetcoinlistBloc extends Bloc<GetcoinlistEvent, GetcoinlistState> {
  GetcoinlistBloc() : super(GetcoinlistInitial()) {
    on<GetcoinlistEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
