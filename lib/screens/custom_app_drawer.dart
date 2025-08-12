// File: custom_app_drawer.dart
import 'package:flutter/material.dart';

import 'home_screen.dart';

class CustomAppDrawer extends StatelessWidget {
  final VoidCallback? onWeeklyMealsPressed;
  final VoidCallback? onOrderHistoryPressed;
  final VoidCallback? onStatisticsPressed;
  final VoidCallback? onLogoutPressed;

  const CustomAppDrawer({
    super.key,
    this.onWeeklyMealsPressed,
    this.onOrderHistoryPressed,
    this.onStatisticsPressed,
    this.onLogoutPressed,
  });

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
                      Navigator.pop(context);
                      onWeeklyMealsPressed?.call();
                    },
                  ),

                  _buildMenuItem(
                    icon: Icons.history,
                    iconColor: Colors.blue,
                    title: 'Lịch sử đặt món',
                    onTap: () {
                      Navigator.pop(context);
                      onOrderHistoryPressed?.call();
                    },
                  ),

                  _buildMenuItem(
                    icon: Icons.assessment,
                    iconColor: Colors.green,
                    title: 'Thống kê suất ăn',
                    onTap: () {
                      Navigator.pop(context);
                      onStatisticsPressed?.call();
                    },
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
      leading: Icon(
        icon,
        color: iconColor,
        size: 24,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
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
                Navigator.of(context).pop();
                onLogoutPressed?.call();
              },
            ),
          ],
        );
      },
    );
  }
}

// File: weekly_meals_view.dart
class _WeeklyMealsViewState extends State<WeeklyMealsView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: const Color(0xFF2D3748),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.location_on, color: Colors.white),
            onPressed: () {},
          ),
          title: const Text(
            'ĐẶT CƠM',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),
          ),
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            ),
          ],
        ),

        // Sử dụng CustomAppDrawer
        endDrawer: CustomAppDrawer(
          onWeeklyMealsPressed: () {
            // Logic điều hướng đến trang món ăn trong tuần
            print('Điều hướng đến món ăn trong tuần');
          },
          onOrderHistoryPressed: () {
            // Logic điều hướng đến lịch sử đặt món
            print('Điều hướng đến lịch sử đặt món');
          },
          onStatisticsPressed: () {
            // Logic điều hướng đến thống kê
            print('Điều hướng đến thống kê');
          },
          onLogoutPressed: () {
            // Logic đăng xuất
            _performLogout();
          },
        ),

        body: Container(
          child: const Center(
            child: Text('Nội dung trang chính'),
          ),
        ),
      ),
    );
  }

  void _performLogout() {
    // Thực hiện logic đăng xuất
    print('Đăng xuất thành công');
    // Navigator.pushReplacementNamed(context, '/login');
  }
}

// Ví dụ sử dụng trong trang khác:
class AnotherPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trang khác'),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: CustomAppDrawer(
        onWeeklyMealsPressed: () {
          Navigator.pushNamed(context, '/weekly-meals');
        },
        onOrderHistoryPressed: () {
          Navigator.pushNamed(context, '/order-history');
        },
        onStatisticsPressed: () {
          Navigator.pushNamed(context, '/statistics');
        },
        onLogoutPressed: () {
          // Custom logout logic
          _handleLogout(context);
        },
      ),
      body: Center(
        child: Text('Trang khác với cùng drawer'),
      ),
    );
  }

  void _handleLogout(BuildContext context) {
    // Custom logout implementation
    Navigator.pushNamedAndRemoveUntil(
        context,
        '/login',
            (route) => false
    );
  }
}