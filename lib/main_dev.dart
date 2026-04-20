import 'package:bike_rental_app/ui/states/map_state.dart';
import 'package:provider/provider.dart';
import 'main_common.dart';

import 'data/repositories/station_repository.dart';
import 'data/repositories/bike_repository.dart';
import 'data/repositories/booking/booking_repository.dart';
import 'data/repositories/booking/booking_repository_firebase.dart';
import 'package:bike_rental_app/data/repositories/pass/pass_repository.dart';

import 'ui/states/booking_state.dart';
import 'package:bike_rental_app/ui/states/pass_state.dart';
import 'ui/states/station_state.dart';

List<InheritedProvider> get devProviders {
  return [
    Provider<StationRepository>(create: (_) => StationRepository()),

    Provider<BikeRepository>(create: (_) => BikeRepository()),

    Provider<BookingRepository>(create: (_) => BookingRepositoryFirebase()),

    ChangeNotifierProvider<StationState>(
      create: (context) => StationState(
        context.read<StationRepository>(),
        context.read<BikeRepository>(),
      ),
    ),

    ChangeNotifierProvider<MapState>(
      create: (context) => MapState(context.read<BikeRepository>()),
    ),

    ChangeNotifierProvider<BookingState>(
      create: (context) => BookingState(context.read<BookingRepository>()),),

    Provider<PassRepository>(create: (_) => PassRepository()),
    ChangeNotifierProvider<PassState>(
      create: (context) => PassState(),
    ),
  ];
}

void main() {
  mainCommon(devProviders);
}
