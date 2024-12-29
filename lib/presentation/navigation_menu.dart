import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:get/get.dart';
import 'package:likya_app/presentation/home/pages/home_screen.dart';
import 'package:likya_app/presentation/notification_screen.dart';
import 'package:likya_app/presentation/setting_screen.dart';
import 'package:likya_app/presentation/transaction_screen.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  final controller = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            width: 327,
            height: 78,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              color: Color(0xFF2FA9A2),
              borderRadius: BorderRadius.circular(30),
            ),
            child: NavigationBar(
              elevation: 0,
              selectedIndex: controller.selectedIndex.value,
              onDestinationSelected: (index) {
                controller.selectedIndex.value = index;
              },
              animationDuration: Duration(milliseconds: 500),
              indicatorColor: Colors.transparent,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              destinations: [
                NavigationDestination(
                  icon: Icon(Ionicons.home_outline, color: Colors.white),
                  selectedIcon: Icon(Ionicons.home, color: Colors.white),
                  label: 'Accueil',
                ),
                NavigationDestination(
                  icon: Icon(Ionicons.stats_chart_outline, color: Colors.white),
                  selectedIcon: Icon(Ionicons.stats_chart, color: Colors.white),
                  label: 'Transaction',
                ),
                NavigationDestination(
                  icon:
                      Icon(Ionicons.notifications_outline, color: Colors.white),
                  selectedIcon:
                      Icon(Ionicons.notifications, color: Colors.white),
                  label: 'Notification',
                ),
                NavigationDestination(
                  icon: Icon(Ionicons.settings_outline, color: Colors.white),
                  selectedIcon: Icon(Ionicons.settings, color: Colors.white),
                  label: 'Paramètre',
                ),
              ],
              backgroundColor: Color(0xFF2FA9A2),
            ),
          ),
        ),
      ),
      body: Obx(
        () => controller.screens[controller.selectedIndex.value],
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = const [
    HomeScreen(),
    TransactionScreen(),
    NotificationScreen(),
    SettingScreen(),
  ];
}
