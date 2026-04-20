import 'package:flutter/material.dart';
import 'package:bike_rental_app/ui/screens/pass/widgets/purchase_pass_list.dart';

class PassContent extends StatelessWidget {
	const PassContent({super.key});

	@override
	Widget build(BuildContext context) {
		return SafeArea(
				child: const PurchasePassList(),
		);
	}
}


