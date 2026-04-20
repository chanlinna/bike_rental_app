import 'package:bike_rental_app/models/pass/active_pass.dart';
import "package:bike_rental_app/models/pass/pass.dart";

abstract class PassRepository {
  Future<List<Pass>> getAvailablePasses();
  Future<ActivePass?> getActivePass();

  Future<ActivePass> activatePass({
    required String passId,
    DateTime? startDate,
  });

  Future<void> clearActivePass();
}
