import 'package:flutter/material.dart';
import 'package:bike_rental_app/ui/screens/pass/widgets/pass_content.dart';
import 'package:bike_rental_app/ui/screens/pass/view_model/pass_view_model.dart';
import 'package:provider/provider.dart';

class PassScreen extends StatelessWidget {
  const PassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PassViewModel>(
      create: (_) => PassViewModel(context.read<PassState>())..initialize(),
      child: Scaffold(body: const PassContent()),
    );
  }
}
