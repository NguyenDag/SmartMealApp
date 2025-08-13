import 'package:flutter/material.dart';
import '../models/order_history_model.dart';
import 'custom_app_drawer.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  final List<OrderHistory> orderHistory = List.generate(
    30,
    (index) => OrderHistory(
      id: index + 1,
      dishName:
          ['Cơm gà', 'Miến xào', 'Cơm trộn', 'Mỳ xào', 'Cơm tấm'][index % 5],
      supplyDate: ['4/8/2025', '3/8/2025', '1/8/2025', '30/7/2025'][index % 4],
      status: 'Đã đặt',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF7F7F7),
        appBar: AppBar(
          backgroundColor: const Color(0xFF2D3748),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.location_on, color: Colors.orange),
            onPressed: () {},
          ),
          title: const Text(
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
            // Header với icon lịch sử và tiêu đề
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.history,
                      color: Colors.blue,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Lịch sử đặt món',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            Divider(thickness: 1, color: Color(0xFF093200)),

            const SizedBox(height: 8),

            Expanded(child: HistoryTable(orderHistory: orderHistory)),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class HistoryTable extends StatelessWidget {
  final List<OrderHistory> orderHistory;

  const HistoryTable({super.key, required this.orderHistory});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        // color: Color(0xFFF7F7F7),
        color: Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(8.0),
        /*boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],*/
      ),
      child: Column(
        children: [
          // Table header
          Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            child: const Row(
              children: [
                Expanded(
                  flex: 1,
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
                  flex: 2,
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
                  flex: 2,
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
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Trạng thái',
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: orderHistory.length,
                    itemBuilder: (context, index) {
                      final order = orderHistory[index];

                      return Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFF000000),
                              width: 1,
                            ),
                          ),
                          borderRadius:
                              index == orderHistory.length - 1
                                  ? BorderRadius.only(
                                    bottomLeft: Radius.circular(5.0),
                                    bottomRight: Radius.circular(5.0),
                                  )
                                  : null,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  order.id.toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  order.dishName,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  order.supplyDate,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  order.status,
                                  style: const TextStyle(
                                    fontSize: 12,
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
            ),
          ),
        ],
      ),
    );
  }
}
