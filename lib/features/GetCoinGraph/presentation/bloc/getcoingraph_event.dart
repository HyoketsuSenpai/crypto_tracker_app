part of 'getcoingraph_bloc.dart';

abstract class GetcoingraphEvent extends Equatable {
  const GetcoingraphEvent();

  @override
  List<Object> get props => [];
}

class GetCoinGraphEvent extends GetcoingraphEvent {
  final String id;
  final int days;

  const GetCoinGraphEvent({required this.id, required this.days});


}