import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_meal/blocs/meal/statistic/statistic_event.dart';
import 'package:smart_meal/blocs/meal/statistic/statistic_state.dart';

import '../../../models/statistic_model.dart';

class StatisticBloc extends Bloc<StatisticEvent, StatisticState> {
  StatisticBloc() : super(StatisticInitial()) {
    on<LoadStatistic>(_onLoadStatistic);
    on<SearchStatistic>(_onSearchStatistic);
  }

  List<Statistic> _statistics = [];

  Future<void> _onLoadStatistic(
    LoadStatistic event,
    Emitter<StatisticState> emit,
  ) async {
    emit(StatisticLoading());

    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));

      final expenses = _getMockExpenses(event.month, event.year);
      //dùng để gộp (reduce) toàn bộ phần tử của danh sách thành một giá trị duy nhất
      final total = expenses.fold(0.0, (sum, item) => sum + item.amount);

      emit(StatisticLoaded(expenses, total, event.month, event.year));
    } catch (e) {
      emit(StatisticError('Không thể tải dữ liệu: ${e.toString()}'));
    }
  }

  List<Statistic> _getMockExpenses(int month, int year) {
    return [
      Statistic(
        id: 1,
        dishName: 'Cơm gà',
        amount: 25000,
        supplyDate: DateTime(year, month, 4),
      ),
      Statistic(
        id: 2,
        dishName: 'Mỳ xào',
        amount: 25000,
        supplyDate: DateTime(year, month, 5),
      ),
      Statistic(
        id: 3,
        dishName: 'Cơm trộn',
        amount: 35000,
        supplyDate: DateTime(year, month, 7),
      ),
      Statistic(
        id: 4,
        dishName: 'Mỳ cay',
        amount: 25000,
        supplyDate: DateTime(year, month, 7),
      ),
      Statistic(
        id: 1,
        dishName: 'Cơm gà',
        amount: 25000,
        supplyDate: DateTime(year, month, 4),
      ),
      Statistic(
        id: 2,
        dishName: 'Mỳ xào',
        amount: 25000,
        supplyDate: DateTime(year, month, 5),
      ),
      Statistic(
        id: 3,
        dishName: 'Cơm trộn',
        amount: 35000,
        supplyDate: DateTime(year, month, 7),
      ),
      Statistic(
        id: 4,
        dishName: 'Mỳ cay',
        amount: 25000,
        supplyDate: DateTime(year, month, 7),
      ),
      Statistic(
        id: 1,
        dishName: 'Cơm gà',
        amount: 25000,
        supplyDate: DateTime(year, month, 4),
      ),
      Statistic(
        id: 2,
        dishName: 'Mỳ xào',
        amount: 25000,
        supplyDate: DateTime(year, month, 5),
      ),
      Statistic(
        id: 3,
        dishName: 'Cơm trộn',
        amount: 35000,
        supplyDate: DateTime(year, month, 7),
      ),
      Statistic(
        id: 4,
        dishName: 'Mỳ cay',
        amount: 25000,
        supplyDate: DateTime(year, month, 7),
      ),
      Statistic(
        id: 1,
        dishName: 'Cơm gà',
        amount: 25000,
        supplyDate: DateTime(year, month, 4),
      ),
      Statistic(
        id: 2,
        dishName: 'Mỳ xào',
        amount: 25000,
        supplyDate: DateTime(year, month, 5),
      ),
      Statistic(
        id: 3,
        dishName: 'Cơm trộn',
        amount: 35000,
        supplyDate: DateTime(year, month, 7),
      ),
      Statistic(
        id: 4,
        dishName: 'Mỳ cay',
        amount: 25000,
        supplyDate: DateTime(year, month, 7),
      ),
      Statistic(
        id: 1,
        dishName: 'Cơm gà',
        amount: 25000,
        supplyDate: DateTime(year, month, 4),
      ),
      Statistic(
        id: 2,
        dishName: 'Mỳ xào',
        amount: 25000,
        supplyDate: DateTime(year, month, 5),
      ),
      Statistic(
        id: 3,
        dishName: 'Cơm trộn',
        amount: 35000,
        supplyDate: DateTime(year, month, 7),
      ),
      Statistic(
        id: 4,
        dishName: 'Mỳ cay',
        amount: 25000,
        supplyDate: DateTime(year, month, 7),
      ),
    ];
  }

  Future<void> _onSearchStatistic(
    SearchStatistic event,
    Emitter<StatisticState> emit,
  ) async {
    add(LoadStatistic(event.month, event.year));
  }
}
