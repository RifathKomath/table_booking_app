import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_booking_app/app/controller/check_screen_controller/check_controller.dart';
import 'package:table_booking_app/app/controller/home_screen_controller/home_controller.dart';
import 'package:table_booking_app/app/view/cart_screen/cart_screen.dart';
import 'package:table_booking_app/app/view/check_screen/check_screen.dart';
import 'package:table_booking_app/app/view/home_screen/home_screen.dart';

import '../../controller/bottom_navigation_controller/bottom_controller.dart';

class BottomNavigationWidget extends StatelessWidget {
  BottomNavigationWidget({super.key});

  final HomeController controller = Get.put(HomeController());
  final CheckController checkController = Get.put(CheckController());
  final NavigationController navController = Get.put(NavigationController());

  final List<Widget> screens = [HomeScreen(), CheckScreen(), ShoppingCartScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Center(
          child: screens[navController.selectedIndex.value],
        );
      }),
      bottomNavigationBar: Obx(() {
        return Container(
          height: 75,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, -1),
              ),
            ],
          ),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.grid_view),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: '',
              ),
            ],
            currentIndex: navController.selectedIndex.value,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              navController.changeTabIndex(index);
              controller.isSubmitted.value = false;
              checkController.isContainerVisible.value = false;
            },
          ),
        );
      }),
    );
  }
}
