import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/bike_view_model.dart';
import 'bike_tile.dart';
import '../../../theme/theme.dart';

class BikeListContent extends StatelessWidget {
  const BikeListContent({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<BikeViewModel>();
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.bikes.isEmpty) {
      return const Center(child: Text("No bikes available at this station."));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppTextStyles.spaceS),
      itemCount: viewModel.bikes.length,
      itemBuilder: (context, index) => BikeTile(bike: viewModel.bikes[index]),
    );
  }
}
