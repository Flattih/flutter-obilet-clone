import 'package:cashback/core/extension/context_extension.dart';
import 'package:cashback/features/help/help_screen.dart';
import 'package:cashback/features/home/screens/home_screen.dart';
import 'package:cashback/features/profile/profile_screen.dart';
import 'package:cashback/features/my_travels/my_travels_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavBar extends ConsumerStatefulWidget {
  static const routeName = '/bottom-nav-bar';
  const BottomNavBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends ConsumerState<BottomNavBar> {
  final List<Widget> _pages = [const HomeScreen(), const MyTravelsScreen(), const HelpScreen(), const ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    final bottomBarIndex = ref.watch(bottomBarIndexProvider);
    return Scaffold(
      body: _pages[bottomBarIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: context.secondaryColor,
        showUnselectedLabels: true,
        currentIndex: bottomBarIndex,
        onTap: (index) {
          ref.read(bottomBarIndexProvider.notifier).update((state) => index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Ara',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.bus_alert_outlined), label: 'Seyahatlerim'),
          BottomNavigationBarItem(icon: Icon(Icons.help_outline), label: 'Yardım'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline_outlined), label: 'Hesabım'),
        ],
      ),
    );
  }
}

final bottomBarIndexProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});

enum BottomBarState {
  homeScreen(0),
  ticketScreen(1),
  helpScreen(2),
  profileScreen(3);

  const BottomBarState(this.state);
  final int state;
}
