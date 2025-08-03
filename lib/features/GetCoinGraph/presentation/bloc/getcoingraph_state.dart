part of 'getcoingraph_bloc.dart';

abstract class GetcoingraphState extends Equatable {
  final List<Object> p;

  const GetcoingraphState([this.p = const <Object>[]]);  

  @override
  List<Object> get props => p;
}
class Empty extends GetcoingraphState {}

class Loading extends GetcoingraphState {}

class Loaded extends GetcoingraphState {
  final List<TimePrice> points;

  Loaded({required this.points}):super([points]);
}

class Error extends GetcoingraphState {
  final String message;

  Error({required this.message}):super([message]);

}
