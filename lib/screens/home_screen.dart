import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../blocs/meal/home/meal_bloc.dart';
import '../blocs/meal/home/meal_event.dart';
import '../blocs/meal/home/meal_state.dart';
import '../models/meal_model.dart';
import 'custom_app_drawer.dart';

class WeeklyMealsScreen extends StatelessWidget {
  const WeeklyMealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MealBloc()..add(LoadWeeklyMeals()),
      child: const WeeklyMealsView(),
    );
  }
}

class WeeklyMealsView extends StatefulWidget {
  const WeeklyMealsView({super.key});

  @override
  State<WeeklyMealsView> createState() => _WeeklyMealsViewState();
}

class _WeeklyMealsViewState extends State<WeeklyMealsView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Color(0xFF2D3748),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.location_on, color: Colors.orange),
            onPressed: () {},
          ),
          title: Text(
            'ĐẶT CƠM',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Builder(
              builder:
                  (context) => IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
            ),
          ],
        ),
        endDrawer: CustomAppDrawer(),
        body: BlocListener<MealBloc, MealState>(
          listener: (context, state) {
            if (state is MealOrderSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is MealCancelSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.orange,
                ),
              );
            } else if (state is MealError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Xin chào, Lê Văn Thành',
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Icon(Icons.restaurant_menu, color: Colors.orange, size: 24),
                    SizedBox(width: 8),
                    Text(
                      'Món ăn trong tuần này',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              Divider(thickness: 1),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Text(
                  'Lưu ý: đặt cơm chậm nhất trước 10:00 AM',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<MealBloc, MealState>(
                  builder: (context, state) {
                    if (state is MealLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is MealLoaded ||
                        state is MealOrderSuccess ||
                        state is MealCancelSuccess) {
                      List<Meal> meals = [];
                      if (state is MealLoaded) meals = state.meals;
                      if (state is MealOrderSuccess) meals = state.meals;
                      if (state is MealCancelSuccess) meals = state.meals;

                      return ListView.builder(
                        padding: EdgeInsets.all(16),
                        itemCount: meals.length,
                        itemBuilder: (context, index) {
                          return MealCard(meal: meals[index]);
                        },
                      );
                    } else if (state is MealError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error, size: 64, color: Colors.red),
                            SizedBox(height: 16),
                            Text(
                              state.message,
                              style: TextStyle(fontSize: 16, color: Colors.red),
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                context.read<MealBloc>().add(LoadWeeklyMeals());
                              },
                              child: Text('Thử lại'),
                            ),
                          ],
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MealCard extends StatelessWidget {
  final Meal meal;

  const MealCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(6),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 108,
                decoration: BoxDecoration(color: Colors.orange[100]),
                child:
                    meal.imageUrl != null && meal.imageUrl.isNotEmpty
                        ? Image.asset(
                          meal.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.restaurant,
                              size: 40,
                              color: Colors.orange,
                            ); // Hiển thị icon nếu ảnh không load được
                          },
                        )
                        : Icon(
                          Icons.restaurant,
                          size: 40,
                          color: Colors.orange,
                        ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.name,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Giá: ${NumberFormat('#,###', 'vi_VN').format(meal.price)}₫',
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Ngày: ${DateFormat('dd/MM/yyyy').format(meal.serviceDate)}',
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      // if (meal.isOrdered && _canCancelOrder(meal)) ...[
                      Expanded(child: _buildCancelButton(context, meal)),
                      SizedBox(width: 8),
                      // ],
                      Expanded(child: _buildOrderButton(context, meal)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderButton(BuildContext context, Meal meal) {
    final now = DateTime.now();
    final serviceDate = meal.serviceDate;
    final deadlineTime = DateTime(
      serviceDate.year,
      serviceDate.month,
      serviceDate.day,
      10, // 10:00 AM
      0,
    );

    bool isPastDeadline = now.isAfter(deadlineTime);
    bool canOrder = !meal.isOrdered && !isPastDeadline;

    Color buttonColor;
    String buttonText;

    if (meal.isOrdered) {
      buttonColor = Colors.grey;
      buttonText = 'Đã đặt';
    } else if (isPastDeadline) {
      buttonColor = Colors.grey;
      buttonText = 'Hết hạn';
    } else {
      buttonColor = Colors.blue;
      buttonText = 'Đặt món';
    }

    return SizedBox(
      height: 27,
      child: ElevatedButton(
        onPressed:
            canOrder
                ? () {
                  _showOrderConfirmation(context, meal);
                }
                : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 13),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context, Meal meal) {
    Color buttonColor;

    if (!meal.isOrdered) {
      buttonColor = Colors.grey;
    } else {
      buttonColor = Colors.red;
    }

    return SizedBox(
      height: 27,
      child: ElevatedButton(
        onPressed:
            meal.isOrdered && _canCancelOrder(meal)
                ? () {
                  _showCancelConfirmation(context, meal);
                }
                : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'Huỷ món',
          style: TextStyle(fontSize: 13),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  bool _canCancelOrder(Meal meal) {
    final now = DateTime.now();
    final serviceDate = meal.serviceDate;
    final deadlineTime = DateTime(
      serviceDate.year,
      serviceDate.month,
      serviceDate.day,
      10, // 10:00 AM
      0,
    );

    return meal.isOrdered && now.isBefore(deadlineTime);
  }

  void _showOrderConfirmation(BuildContext context, Meal meal) {
    showDialog(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: Text('Xác nhận đặt món'),
            content: Text(
              'Bạn có chắc chắn muốn đặt món "${meal.name}" không?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: Text('Huỷ'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                  context.read<MealBloc>().add(OrderMeal(meal.id));
                },
                child: Text('Đặt món'),
              ),
            ],
          ),
    );
  }

  void _showCancelConfirmation(BuildContext context, Meal meal) {
    showDialog(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: Text('Xác nhận huỷ món'),
            content: Text(
              'Bạn có chắc chắn muốn huỷ món "${meal.name}" không?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: Text('Không'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                  context.read<MealBloc>().add(CancelMealOrder(meal.id));
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text('Huỷ món'),
              ),
            ],
          ),
    );
  }
}
