import 'package:flutter/material.dart';
import 'package:table_booking_app/app/view/bottom_navigation_bar/bottom_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
           theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
      ),
      builder: (context, child) {
        return Container(
          decoration: const BoxDecoration(
           image: DecorationImage(
                  image: AssetImage('assets/images/home_page_bg.jpeg'),
                  fit: BoxFit.cover,
                ),
          ),
          child: child!,
        );
      },
      home: BottomNavigationWidget(),
    );
  }
}

