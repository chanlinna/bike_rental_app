import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'package:bike_rental_app/ui/theme/theme.dart';

import 'package:bike_rental_app/models/station/station.dart';

import 'package:bike_rental_app/data/repositories/station_repository.dart';
import 'package:bike_rental_app/data/repositories/bike_repository.dart';
import 'package:bike_rental_app/ui/states/map_state.dart';
import 'package:bike_rental_app/ui/screens/search/view_model/search_view_model.dart';
import 'package:bike_rental_app/ui/screens/search/search_screen.dart';

import 'package:bike_rental_app/ui/screens/journey/journey_screen.dart';
import 'package:bike_rental_app/ui/screens/map/map_screen.dart';
import 'package:bike_rental_app/ui/screens/pass/pass_screen.dart';
import 'package:bike_rental_app/ui/screens/bike/bike_list_screen.dart';

void mainCommon() {
  final stationRepo = StationRepository();
  final bikeRepo = BikeRepository();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MapState(stationRepo, bikeRepo),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const MapScreen(), 
    const JourneyScreen(),
    const PassScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      onGenerateRoute: (settings) {
        if (settings.name == '/bikes') {
          final station = settings.arguments as Station;

          return MaterialPageRoute(
            builder: (context) => BikeListScreen(station: station),
          );
        }

        if (settings.name == '/search') {
          return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (_) => SearchViewModel(),
              child: const SearchScreen(),
            ),
          );
        }
        return null;
      },
      home: Scaffold(
        // IndexedStack keeps the Map state alive when switching tabs
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
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