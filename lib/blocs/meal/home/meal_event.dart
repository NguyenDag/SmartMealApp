import 'package:equatable/equatable.dart';

abstract class MealEvent extends Equatable {
  const MealEvent();

  @override
  List<Object> get props => [];
}

class LoadWeeklyMeals extends MealEvent {}

class OrderMeal extends MealEvent {
  final String mealId;

  const OrderMeal(this.mealId);

  @override
  List<Object> get props => [mealId];
}

class CancelMealOrder extends MealEvent {
  final String mealId;

  const CancelMealOrder(this.mealId);

  @override
  List<Object> get props => [mealId];
}
