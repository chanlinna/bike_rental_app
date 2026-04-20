import 'package:bike_rental_app/ui/screens/journey/journey_screen.dart';
import 'package:bike_rental_app/ui/screens/map/map_screen.dart';
import 'package:bike_rental_app/ui/screens/pass/pass_screen.dart';
import 'package:bike_rental_app/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void mainCommon(List<InheritedProvider> providers) {
  runApp(
    MultiProvider(providers: providers, child: const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    const MapScreen(),
    const JourneyScreen(),
    PassScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,

      onGenerateRoute: (settings) {
        if (settings.name == '/subscriptions') {
          return MaterialPageRoute(
            builder: (context) => const PassScreen(),
          );
        }

        return null;
      },

      home: Scaffold(
        body: IndexedStack(index: _currentIndex, children: _pages),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() => _currentIndex = index);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
            BottomNavigationBarItem(icon: Icon(Icons.route), label: 'Journey'),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_membership),
              label: 'Pass',
            ),
          ],
        ),
      ),
    );
  }
}