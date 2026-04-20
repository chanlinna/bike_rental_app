import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view_model/bike_view_model.dart'; 
import '../../../models/station/station.dart';
import '../../theme/theme.dart';

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
    final viewModel = context.watch<BikeViewModel>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.station.stationName)),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : viewModel.bikes.isEmpty
          ? const Center(child: Text("No bikes available at this station."))
          : ListView.builder(
              padding: const EdgeInsets.all(AppTextStyles.spaceS),
              itemCount: viewModel.bikes.length,
              itemBuilder: (context, index) {
                final bike = viewModel.bikes[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: AppTextStyles.spaceXS),
                  child: ListTile(
                    leading: const Icon(
                      Icons.pedal_bike,
                      color: AppColors.primary,
                    ),
                    title: Text("Bike ID: ${bike.bikeId}"),
                    subtitle: Text("Status: ${bike.bikeStatus.name}"),
                    trailing: ElevatedButton(
                      onPressed: bike.bikeStatus.name == 'available'
                          ? () {
                              Navigator.pushNamed(
                                context,
                                '/booking',
                                arguments: bike.bikeId,
                              );
                            }
                          : null,
                      child: const Text("Rent"),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
