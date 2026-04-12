import 'package:bike_rental_app/ui/screens/journey/journey_screen.dart';
import 'package:bike_rental_app/ui/screens/map/map_screen.dart';
import 'package:bike_rental_app/ui/screens/pass/pass_screen.dart';
import 'package:flutter/material.dart';

void mainCommon() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    MapScreen(),
    JourneyScreen(),
    PassScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        body: _pages[_currentIndex],

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
            BottomNavigationBarItem(icon: Icon(Icons.route), label: 'Journey'),
            BottomNavigationBarItem(
              icon: Icon(Icons.confirmation_number),
              label: 'Pass',
            ),
          ],
        ),
      ),
    );
  }
}
