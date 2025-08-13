import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'login_screen.dart';
import 'order_history_screen.dart';

class CustomAppDrawer extends StatelessWidget {
  const CustomAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            // Header của drawer
            _buildDrawerHeader(),

            // Các mục menu
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildMenuItem(
                    icon: Icons.restaurant_menu,
                    iconColor: Colors.orange,
                    title: 'Món ăn trong tuần',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const WeeklyMealsScreen(),
                        ),
                      );
                    },
                  ),

                  _buildMenuItem(
                    icon: Icons.history,
                    iconColor: Colors.blue,
                    title: 'Lịch sử đặt món',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const OrderHistoryScreen(),
                        ),
                      );
                    },
                  ),

                  _buildMenuItem(
                    icon: Icons.assessment,
                    iconColor: Colors.green,
                    title: 'Thống kê suất ăn',
                    onTap: () {},
                  ),

                  _buildMenuItem(
                    icon: Icons.logout,
                    iconColor: Colors.blue,
                    title: 'Đăng xuất',
                    onTap: () {
                      Navigator.pop(context);
                      _showLogoutConfirmDialog(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.location_on, color: Colors.orange),
              onPressed: () {},
            ),
            const SizedBox(height: 8),
            Text(
              'ĐẶT CƠM',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor, size: 24),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
    );
  }

  void _showLogoutConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận đăng xuất'),
          content: const Text('Bạn có chắc chắn muốn đăng xuất không?'),
          actions: [
            TextButton(
              child: const Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Đăng xuất',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
