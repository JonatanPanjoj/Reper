import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavigationBar({super.key, required this.currentIndex});

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home/0');
        break;
      case 1:
        context.go('/home/1');
        break;
      case 2:
        context.go('/home/2');
        break;
      case 3:
        context.go('/home/3');
        break;
      case 4:
        context.go('/home/4');
        break;
      default:
        context.go('/home/0');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (value) {
        onItemTapped(context, value);
      },
      indicatorShape: const CircleBorder(),
      height: 60,
      elevation: 0,
      selectedIndex: currentIndex,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_rounded), label: ''),
        NavigationDestination(icon: Icon(Icons.album), label: ''),
        NavigationDestination(icon: Icon(Icons.group), label: ''),
        NavigationDestination(icon: Icon(Icons.music_note), label: ''),
        NavigationDestination(icon: Icon(Icons.person), label: ''),
      ],
    );
  }
}
