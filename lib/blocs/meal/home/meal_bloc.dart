import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/meal_model.dart';
import 'meal_event.dart';
import 'meal_state.dart';

class MealBloc extends Bloc<MealEvent, MealState> {
  MealBloc() : super(MealInitial()) {
    on<LoadWeeklyMeals>(_onLoadWeeklyMeals);
    on<OrderMeal>(_onOrderMeal);
    on<CancelMealOrder>(_onCancelMealOrder);
  }

  List<Meal> _meals = [];

  void _onLoadWeeklyMeals(
    LoadWeeklyMeals event,
    Emitter<MealState> emit,
  ) async {
    // emit(MealLoading());

    try {
      // Simulate API call
      // await Future.delayed(Duration(milliseconds: 500));

      final now = DateTime.now();
      _meals = [
        Meal(
          id: '1',
          name: 'Cơm gà',
          imageUrl: 'assets/images/com_ga.jpg',
          price: 25000,
          serviceDate: DateTime(now.year, now.month, now.day - 1),
        ),
        Meal(
          id: '2',
          name: 'Phở gà',
          imageUrl: 'assets/images/pho_ga.jpg',
          price: 25000,
          serviceDate: DateTime(now.year, now.month, now.day),
        ),
        Meal(
          id: '3',
          name: 'Mỳ cay',
          imageUrl: 'assets/images/my_cay.jpg',
          price: 25000,
          serviceDate: DateTime(now.year, now.month, now.day + 1),
          isOrdered: true,
        ),
        Meal(
          id: '4',
          name: 'Cơm rang',
          imageUrl: 'assets/images/com_rang.jpg',
          price: 25000,
          serviceDate: DateTime(now.year, now.month, now.day + 2),
        ),
        Meal(
          id: '5',
          name: 'Cơm thố',
          imageUrl: 'assets/images/com_tho.jpg',
          price: 35000,
          serviceDate: DateTime(now.year, now.month, now.day + 2),
        ),
        Meal(
          id: '6',
          name: 'Cơm tấm',
          imageUrl: 'assets/images/com_tam.jpg',
          price: 30000,
          serviceDate: DateTime(now.year, now.month, now.day + 3),
        ),
        Meal(
          id: '7',
          name: 'Cơm trộn',
          imageUrl: 'assets/images/com_tron.jpg',
          price: 25000,
          serviceDate: DateTime(now.year, now.month, now.day + 4),
        ),
      ];

      emit(MealLoaded(_meals));
    } catch (e) {
      emit(MealError('Không thể tải danh sách món ăn'));
    }
  }

  void _onOrderMeal(OrderMeal event, Emitter<MealState> emit) {
    try {
      final mealIndex = _meals.indexWhere((meal) => meal.id == event.mealId);
      if (mealIndex != -1) {
        _meals[mealIndex] = _meals[mealIndex].copyWith(
          isOrdered: true,
          orderedAt: DateTime.now(),
        );
        emit(MealOrderSuccess(_meals, 'Đặt món ăn thành công'));
      } else {
        emit(MealError('Không tìm thấy món ăn'));
      }
    } catch (e) {
      emit(MealError('Không thể đặt món ăn'));
    }
  }

  void _onCancelMealOrder(CancelMealOrder event, Emitter<MealState> emit) {
    try {
      final mealIndex = _meals.indexWhere((meal) => meal.id == event.mealId);
      if (mealIndex != -1) {
        _meals[mealIndex] = _meals[mealIndex].copyWith(
          isOrdered: false,
          orderedAt: null,
        );
        emit(MealCancelSuccess(_meals, 'Hủy đặt món ăn thành công'));
      }
    } catch (e) {
      emit(MealError('Không thể hủy món'));
    }
  }
}
