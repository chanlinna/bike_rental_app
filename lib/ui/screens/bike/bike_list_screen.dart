import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/station/station.dart';
import '../../theme/theme.dart';
import 'view_model/bike_view_model.dart';
import 'widgets/bike_list_content.dart'; 

class BikeListScreen extends StatefulWidget {
  final Station station;

  const BikeListScreen({super.key, required this.station});

  @override
  State<BikeListScreen> createState() => _BikeListScreenState();
}

class _BikeListScreenState extends State<BikeListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<BikeViewModel>().fetchBikesForStation(
            widget.station.stationId,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.station.stationName,
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w800,
            color: AppColors.secondary,
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: const BikeListContent(),
    );
  }
}