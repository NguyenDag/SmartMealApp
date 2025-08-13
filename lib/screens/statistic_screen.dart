import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_meal/blocs/meal/statistic/statistic_state.dart';

import '../blocs/meal/statistic/statistic_bloc.dart';
import '../blocs/meal/statistic/statistic_event.dart';
import '../models/statistic_model.dart';
import 'custom_app_drawer.dart';

class StatisticScreen extends StatelessWidget {
  const StatisticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              StatisticBloc()
                ..add(LoadStatistic(DateTime.now().month, DateTime.now().year)),
      child: const StatisticView(),
    );
  }
}

class StatisticView extends StatefulWidget {
  const StatisticView({super.key});

  @override
  State<StatefulWidget> createState() => _StatisticViewState();
}

class _StatisticViewState extends State<StatisticView> {
  int selectedMonth = 8;
  int selectedYear = 2025;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF7F7F7),
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
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.assessment, color: Colors.green),
                      SizedBox(width: 8),
                      Text(
                        'Thống kê suất ăn',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Divider(thickness: 1, color: Color(0xFF093200)),

                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text(
                        'Tháng',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),

                      const SizedBox(width: 5),

                      Container(
                        height: 30,
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            value: selectedMonth,
                            items:
                                List.generate(12, (index) => index + 1)
                                    .map(
                                      (month) => DropdownMenuItem(
                                        value: month,
                                        child: Text(
                                          month.toString(),
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  selectedMonth = value;
                                });
                              }
                            },
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      const Text(
                        'Năm',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),

                      const SizedBox(width: 5),

                      Container(
                        height: 30,
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            value: selectedYear,
                            items:
                                List.generate(5, (index) => 2021 + index)
                                    .map(
                                      (year) => DropdownMenuItem(
                                        value: year,
                                        child: Text(
                                          year.toString(),
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  selectedYear = value;
                                });
                              }
                            },
                          ),
                        ),
                      ),

                      const Spacer(),

                      SizedBox(
                        height: 30,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<StatisticBloc>().add(
                              SearchStatistic(selectedMonth, selectedYear),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4E89FF),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text(
                            'Tìm kiếm',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: BlocBuilder<StatisticBloc, StatisticState>(
                  builder: (context, state) {
                    if (state is StatisticLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is StatisticError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error,
                              size: 64,
                              color: Colors.red,
                            ),
                            const SizedBox(height: 16),
                            Text(state.message),
                          ],
                        ),
                      );
                    } else if (state is StatisticLoaded) {
                      return Column(
                        children: [
                          StatisticTable(statistics: state.statistics),
                          // Total amount
                          Container(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Text(
                                  'Tổng tiền trong tháng: ${state.totalAmount.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')} VNĐ',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }

                    return const Center(child: Text('Chưa có dữ liệu'));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatisticTable extends StatelessWidget {
  final List<Statistic> statistics;

  const StatisticTable({super.key, required this.statistics});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Table header
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF4E89FF),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
            ),
            child: const Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'STT',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Tên món',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 11,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Giá (VNĐ)',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Ngày cung cấp',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Table content
          Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: statistics.length,
                itemBuilder: (context, index) {
                  final st = statistics[index];
                  final isEvenRow = index % 2 == 0;

                  return Container(
                    decoration: BoxDecoration(
                      color: isEvenRow ? Color(0xFFEEEEEE) : Color(0xFFFFFFFF),
                      border: Border(
                        bottom: BorderSide(color: Color(0xFF000000), width: 1),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              st.id.toString(),
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              st.dishName,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 11,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              '${st.amount.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')} VNĐ',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              '${st.supplyDate.day}/${st.supplyDate.month}/${st.supplyDate.year}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
