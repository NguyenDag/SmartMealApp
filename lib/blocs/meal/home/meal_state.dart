import 'package:equatable/equatable.dart';

import '../../../models/meal_model.dart';

abstract class MealState extends Equatable {
  const MealState();

  @override
  List<Object> get props => [];
}

class MealInitial extends MealState {}

class MealLoading extends MealState {}

class MealLoaded extends MealState {
  final List<Meal> meals;

  const MealLoaded(this.meals);

  @override
  List<Object> get props => [meals];
}

class MealError extends MealState {
  final String message;

  const MealError(this.message);

  @override
  List<Object> get props => [message];
}

class MealOrderSuccess extends MealState {
  final List<Meal> meals;
  final String message;

  const MealOrderSuccess(this.meals, this.message);

  @override
  List<Object> get props => [meals, message];
}

class MealCancelSuccess extends MealState {
  final List<Meal> meals;
  final String message;

  const MealCancelSuccess(this.meals, this.message);

  @override
  List<Object> get props => [meals, message];
}