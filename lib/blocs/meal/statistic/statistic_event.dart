import 'package:equatable/equatable.dart';

import '../../../models/statistic_model.dart';

abstract class StatisticEvent extends Equatable{
  const StatisticEvent();

  @override
  List<Object> get props => [];
}

class LoadStatistic extends StatisticEvent{
  final int month;
  final int year;

  const LoadStatistic(this.month, this.year);

  @override
  List<Object> get props => [month, year];
}

class SearchStatistic extends StatisticEvent{
  final int month;
  final int year;

  const SearchStatistic(this.month, this.year);

  @override
  List<Object> get props => [month, year];
}