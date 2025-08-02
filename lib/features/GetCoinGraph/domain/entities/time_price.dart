import 'package:equatable/equatable.dart';

class TimePrice extends Equatable{
  final DateTime time;
  final double price;

  const TimePrice({required this.time, required this.price});
  
  @override
  List<Object?> get props => [time, price];
}