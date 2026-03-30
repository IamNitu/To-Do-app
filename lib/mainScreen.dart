import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/screens/pages/calanderPage/calander_screen.dart';
import 'package:social_app/screens/pages/homePage/home_Screen.dart';
import 'package:social_app/screens/pages/profilePage/profile_screen.dart';

class MainController extends GetxController {
  var currentIndex = 0.obs;

  final pages = [
   HomeScreen(),
   CalanderScreen(),
   ProfileScreen(),
];

  void changeTab(int index) {
    currentIndex.value = index;
  }
}

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final MainController controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: controller.pages[controller.currentIndex.value],

        // BOTTOM NAV BAR
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeTab,

          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,

          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: "Calendar",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      );
    });
  }
}