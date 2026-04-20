import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/theme/theme.dart';
import 'ui/screens/map/map_screen.dart';
import 'ui/screens/journey/journey_screen.dart';
import 'ui/screens/pass/pass_screen.dart';
import 'ui/screens/search/view_model/search_view_model.dart';
import 'ui/screens/search/search_screen.dart';
import 'ui/screens/bike/bike_list_screen.dart';
import 'models/station/station.dart';

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

  void switchTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Widget> get _pages => [MapScreen(), JourneyScreen(onGoToMap: () => switchTab(0)), PassScreen()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,

      onGenerateRoute: (settings) {
        if (settings.name == '/bikes') {
          final station = settings.arguments as Station;

          return MaterialPageRoute(
            builder: (_) => BikeListScreen(station: station),
          );
        }

        if (settings.name == '/search') {
          return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
              create: (_) => SearchViewModel(),
              child: const SearchScreen(),
            ),
          );
        }
        
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
          onTap: switchTab,
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