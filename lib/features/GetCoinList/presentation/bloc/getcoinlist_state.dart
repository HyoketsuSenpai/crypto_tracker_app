part of 'getcoinlist_bloc.dart';

abstract class GetcoinlistState extends Equatable {
  final List<Object> p;

  const GetcoinlistState([this.p = const <Object>[]]);  

  @override
  List<Object> get props => p;
}

class Empty extends GetcoinlistState {}
class Loading extends GetcoinlistState {}
class Error extends GetcoinlistState {
  final String message;

  Error({required this.message}):super([message]);
}
class Loaded extends GetcoinlistState {
  final List<Coin> coins;

  Loaded({required this.coins}):super([coins]);
}
