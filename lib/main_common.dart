import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/theme/theme.dart';
import 'ui/screens/map/map_screen.dart';
import 'ui/screens/journey/journey_screen.dart';
import 'ui/screens/pass/pass_screen.dart';
import 'ui/screens/search/view_model/search_view_model.dart';
import 'ui/screens/bike/view_model/bike_view_model.dart';
import 'ui/screens/search/search_screen.dart';
import 'ui/screens/bike/bike_list_screen.dart';
import 'package:bike_rental_app/ui/screens/booking/booking_screen.dart';
import 'models/station/station.dart';
import 'ui/states/map_state.dart';

void mainCommon(List<InheritedProvider> providers) {
  runApp(MultiProvider(providers: providers, child: const MyApp()));
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
      theme: appTheme,

      onGenerateRoute: (settings) {
        if (settings.name == '/bikes') {
          final station = settings.arguments as Station;

          return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (_) => BikeViewModel(context.read()),
              child: BikeListScreen(station: station),
            ),
          );
        }

        if (settings.name == '/search') {
          return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (_) => SearchViewModel(context.read<MapState>()),
              child: const SearchScreen(),
            ),
          );
        }

        if (settings.name == '/booking') {
          final bikeId = settings.arguments as String;

          return MaterialPageRoute(
            builder: (context) => BookingScreen(bikeId: bikeId),
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
