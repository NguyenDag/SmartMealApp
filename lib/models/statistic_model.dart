import 'package:equatable/equatable.dart';

class Statistic extends Equatable {
  final int id;
  final String dishName;
  final double amount;
  final DateTime supplyDate;

  const Statistic({
    required this.id,
    required this.dishName,
    required this.amount,
    required this.supplyDate,
  });

  @override
  List<Object?> get props => [id, dishName, amount, supplyDate];
}
