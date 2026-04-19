import 'package:provider/provider.dart';
// import 'dart:html' as html;

import 'main_common.dart';

import 'data/repositories/station_repository.dart';
import 'data/repositories/bike_repository.dart';
import 'data/repositories/booking/booking_repository.dart';
import 'data/repositories/booking/booking_repository_firebase.dart';

import 'ui/states/map_state.dart';
import 'ui/states/booking_state.dart';

List<InheritedProvider> get devProviders {
  return [
    Provider<StationRepository>(create: (_) => StationRepository()),

    Provider<BikeRepository>(create: (_) => BikeRepository()),

    Provider<BookingRepository>(create: (_) => BookingRepositoryFirebase()),

    ChangeNotifierProvider<MapState>(
      create: (context) => MapState(
        context.read<StationRepository>(),
        context.read<BikeRepository>(),
      ),
    ),

    ChangeNotifierProvider<BookingState>(
      create: (context) => BookingState(context.read<BookingRepository>()),
    ),
  ];
}

void main() {
//   // Get the key from the build flag
//   const apiKey = String.fromEnvironment('MAP_API_KEY');

//   // Manually inject the script tag into the HTML head
//   final script = html.ScriptElement()
//     ..src =
//         'https://maps.googleapis.com/maps/api/js?key=$apiKey&libraries=places'
//     ..id = 'google-maps-script';
//   html.querySelector('head')?.append(script);
  mainCommon(devProviders);
}
