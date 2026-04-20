
import 'package:bike_rental_app/main_common.dart';
import 'package:bike_rental_app/data/repositories/pass/pass_repository.dart';
import 'package:bike_rental_app/ui/states/pass_state.dart';
import 'package:provider/provider.dart';

List<InheritedProvider> get devProviders {
  return [
    Provider<PassRepository>(create: (_) => PassRepository()),
    ChangeNotifierProvider<PassState>(
      create: (context) => PassState(),
    ),
  ];
}

void main() {
  mainCommon(devProviders);
}
