import 'package:flutter/material.dart';
import 'package:futa/features/thongBao/presentation/pages/thongBao.dart';
import 'package:futa/features/thongtinCaNhan/presentation/pages/thongTinCaNhan.dart';
import 'package:futa/core/utils/session_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futa/features/dangNhapDangKy/presentation/bloc/dangNhapDangKyBloc.dart';
class TrangChuKH extends StatefulWidget {
  const TrangChuKH({super.key});

  @override
  State<TrangChuKH> createState() => _TrangChuKHState();

}
class _TrangChuKHState extends State<TrangChuKH> {
  int _currentIndex = 0;
  final ScrollController _homeScrollController = ScrollController();

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeTab(scrollController: _homeScrollController),
      const thongBao(),
      const thongTinCaNhan(),
    ];
  }

  void _onTabTapped(int index) {
    if (index == 0 && _currentIndex == 0) {
      // Đang ở HomeTab và nhấn lại icon → scroll lên đầu
      _homeScrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Chuyển tab bình thường
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Trang chủ Futa App"),
          automaticallyImplyLeading: false,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Trang chủ"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Thông báo"),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "Tài khoản"),

        ],
      ),
    );
  }
}



class HomeTab extends StatelessWidget {
  final ScrollController scrollController;

  const HomeTab({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: scrollController,
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                const Text('Tin tức mới', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ElevatedButton(
                  onPressed: () async {
                    context.read<AuthBloc>().add(dangXuat_Event());
                    Navigator.pushReplacementNamed(context, '/');
                  },
                  child: const Text('Logout'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    context.read<AuthBloc>().add(dangXuat_Event());
                    Navigator.pushNamed(context, '/datVeXe');
                  },
                  child: const Text('Đặt vé xe'),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Card(child: Padding(padding: EdgeInsets.all(8), child: Text('Thông báo 1'))),
        const Card(child: Padding(padding: EdgeInsets.all(8), child: Text('Thông báo 2'))),
      ],
    );
  }
}

