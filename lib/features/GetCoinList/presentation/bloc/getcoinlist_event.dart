part of 'getcoinlist_bloc.dart';

abstract class GetcoinlistEvent extends Equatable {
  
  const GetcoinlistEvent();

  @override
  List<Object> get props => [];
}

class GetCoinListEvent extends GetcoinlistEvent {
  final int page;

  const GetCoinListEvent(this.page);

}