import 'package:equatable/equatable.dart';

import '../../../models/statistic_model.dart';

abstract class StatisticState extends Equatable {
  const StatisticState();

  @override
  List<Object> get props => [];
}

class StatisticInitial extends StatisticState {}

class StatisticLoading extends StatisticState {}

class StatisticLoaded extends StatisticState {
  final List<Statistic> statistics;
  final double totalAmount;
  final int selectedMonth;
  final int selectedYear;

  const StatisticLoaded(
    this.statistics,
    this.totalAmount,
    this.selectedMonth,
    this.selectedYear,
  );

  @override
  List<Object> get props => [statistics];
}

class StatisticError extends StatisticState {
  final String message;

  const StatisticError(this.message);

  @override
  List<Object> get props => [message];
}
/*
class StatisticSearchSuccess extends StatisticState {
  final List<Statistic> statistics;

  const StatisticSearchSuccess(this.statistics);

  @override
  List<Object> get props => [statistics];
}*/
