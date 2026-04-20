import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:bike_rental_app/config/firebase_config.dart';
import 'package:bike_rental_app/data/dtos/active_pass_dto.dart';
import 'package:bike_rental_app/data/dtos/pass_dto.dart';
import 'package:bike_rental_app/data/repositories/pass/pass_repository.dart';
import 'package:bike_rental_app/models/pass/active_pass.dart';
import 'package:bike_rental_app/models/pass/pass.dart';

class PassRepositoryFirebase implements PassRepository {
  static const String _passesPath = '/passes.json';
  static const String _activePassPath = '/activePass.json';
  static const String _passHistoryPath = '/passHistory.json';

  static final List<Pass> _defaultPasses = <Pass>[
    Pass(passId: 'pass_daily', passType: PassType.daily, price: 15.0),
    Pass(passId: 'pass_weekly', passType: PassType.weekly, price: 60.0),
    Pass(passId: 'pass_monthly', passType: PassType.monthly, price: 120.0),
  ];

  @override
  Future<List<Pass>> getAvailablePasses() async {
    final url = FirebaseConfig.baseUri.replace(path: _passesPath);
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to load passes: ${response.body}');
    }

    final Map<String, dynamic>? data =
        json.decode(response.body) as Map<String, dynamic>?;

    if (data == null || data.isEmpty) {
      return List<Pass>.unmodifiable(_defaultPasses);
    }

    final List<Pass> passes = <Pass>[];
    for (final entry in data.entries) {
      passes.add(
        PassDto.fromJson(
          entry.key,
          Map<String, dynamic>.from(entry.value as Map),
        ),
      );
    }

    return List<Pass>.unmodifiable(passes);
  }

  @override
  Future<ActivePass?> getActivePass() async {
    final url = FirebaseConfig.baseUri.replace(path: _activePassPath);
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to load active pass: ${response.body}');
    }

    final Map<String, dynamic>? data =
        json.decode(response.body) as Map<String, dynamic>?;

    if (data == null || data.isEmpty) {
      return null;
    }

    final activePass = ActivePassDto.fromJson(data);
    if (_isExpired(activePass)) {
      await clearActivePass();
      return null;
    }

    return activePass;
  }

  @override
  Future<ActivePass> activatePass({
    required String passId,
    DateTime? startDate,
  }) async {
    final current = await getActivePass();
    if (current != null) {
      throw Exception('User already has an active pass');
    }

    final passes = await getAvailablePasses();
    final pass = passes.firstWhere(
      (item) => item.passId == passId,
      orElse: () => throw StateError('Pass with id "$passId" not found.'),
    );

    final start = startDate ?? DateTime.now();
    final activePass = ActivePass(
      passId: pass.passId,
      startDate: start,
      endDate: _calculateEndDate(start, pass.passType),
    );

    final activeUrl = FirebaseConfig.baseUri.replace(path: _activePassPath);
    final activeResponse = await http.put(
      activeUrl,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(ActivePassDto.toJson(activePass)),
    );

    if (activeResponse.statusCode != 200) {
      throw Exception('Failed to activate pass: ${activeResponse.body}');
    }

    final historyUrl = FirebaseConfig.baseUri.replace(path: _passHistoryPath);
    final historyResponse = await http.post(
      historyUrl,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(ActivePassDto.toJson(activePass)),
    );

    if (historyResponse.statusCode != 200 &&
        historyResponse.statusCode != 201) {
      throw Exception('Failed to store pass history: ${historyResponse.body}');
    }

    return activePass;
  }

  @override
  Future<void> clearActivePass() async {
    final url = FirebaseConfig.baseUri.replace(path: _activePassPath);
    final response = await http.delete(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to clear active pass: ${response.body}');
    }
  }

  DateTime _calculateEndDate(DateTime startDate, PassType passType) {
    switch (passType) {
      case PassType.daily:
        return startDate.add(const Duration(days: 1));
      case PassType.weekly:
        return startDate.add(const Duration(days: 7));
      case PassType.monthly:
        return DateTime(startDate.year, startDate.month + 1, startDate.day);
    }
  }

  bool _isExpired(ActivePass activePass) {
    return !activePass.endDate.isAfter(DateTime.now());
  }
}
