import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import 'package:bike_rental_app/ui/widgets/button.dart';

class PassPurchaseSuccessScreen extends StatelessWidget {
	const PassPurchaseSuccessScreen({
		super.key,
	});


	@override
	Widget build(BuildContext context) {
		final double width = MediaQuery.sizeOf(context).width;
		final double scale = (width / 390).clamp(0.85, 1.0);

		return Scaffold(
			backgroundColor: AppColors.surface,
			appBar: AppBar(
				backgroundColor: AppColors.surface,
				elevation: 0,
				scrolledUnderElevation: 0,
				shape: Border(
					bottom: BorderSide(color: AppColors.outlineVariant),
				),
				centerTitle: true,
				title: Text(
					'Current plan',
					style: TextStyle(
						fontSize: 17 * scale,
						fontWeight: FontWeight.w700,
						color: AppColors.onSurface,
					),
				),
			),
			body: SafeArea(
				child: Column(
					children: [
						Expanded(
							child: Center(
								child: Padding(
									padding: const EdgeInsets.all(AppTextStyles.spaceM),
									child: Column(
										mainAxisSize: MainAxisSize.min,
										children: [
											const Icon(
												Icons.shopping_bag_outlined,
												size: 110,
												color: AppColors.primary,
											),
											const SizedBox(height: AppTextStyles.spaceS),
											const Text(
												'Successfully\nsubscribe to the\npass!',
												textAlign: TextAlign.center,
												style: TextStyle(
													fontSize: 42,
													fontWeight: FontWeight.w800,
													color: AppColors.primary,
													height: 1.1,
												),
											),
										],
									),
								),
							),
						),
						Container(
							padding: const EdgeInsets.fromLTRB(
								AppTextStyles.spaceXS,
								AppTextStyles.spaceS,
								AppTextStyles.spaceXS,
								AppTextStyles.spaceS,
							),
							decoration: BoxDecoration(
								color: AppColors.surface,
								border: Border(
									top: BorderSide(color: AppColors.outlineVariant),
								),
							),
							child: PrimaryButton(
								text: 'Continue Booking Process',
								callback: () => Navigator.of(context).pop(),
								backgroundColor: AppColors.primary,
							),
						),
					],
				),
			),
		);
	}
}
