import 'package:bike_rental_app/ui/utils/remaining_time.dart';
import 'package:flutter/material.dart';
import 'package:bike_rental_app/ui/screens/pass/active_pass_screen.dart';
import 'package:bike_rental_app/ui/screens/pass/pass_detail_screen.dart';
import 'package:bike_rental_app/ui/screens/pass/view_model/pass_view_model.dart';
import 'package:bike_rental_app/ui/screens/pass/widgets/passModeCard.dart';
import 'package:bike_rental_app/ui/utils/pass_time.dart';
import 'package:provider/provider.dart';

import '../../../theme/theme.dart';

class PurchasePassList extends StatelessWidget {
	const PurchasePassList({super.key});

  // ========================
  // CANCEL PASS
  // ========================
	Future<void> _confirmCancelPass(BuildContext context) async {
		final bool? shouldCancel = await showDialog<bool>(
			context: context,
			builder: (dialogContext) {
				return AlertDialog(
					title: const Text('Cancel active pass?'),
					content: const Text(
						'If you cancel now, you can purchase another plan immediately.',
					),
					actions: [
						TextButton(
							onPressed: () => Navigator.of(dialogContext).pop(false),
							child: const Text('No'),
						),
						TextButton(
							onPressed: () => Navigator.of(dialogContext).pop(true),
							child: const Text('Yes, cancel'),
						),
					],
				);
			},
		);

		if (shouldCancel == true && context.mounted) {
			context.read<PassViewModel>().cancelActivePass();
		}
	}

  // ========================
  // NAVIGATION TO PASS DETAIL
  // ========================
	void _openPassDetail(BuildContext context, Pass plan) {
		final PassViewModel passViewModel = context.read<PassViewModel>();
		Navigator.of(context).push(
			MaterialPageRoute<void>(
				builder: (_) => ChangeNotifierProvider<PassViewModel>.value(
					value: passViewModel,
					child: PassDetailScreen(plan: plan),
				),
			),
		);
	}

  // ========================
  // NAVIGATION TO ACTIVE PASS
  // ========================
	void _openActivePass(BuildContext context) {
		final PassViewModel passViewModel = context.read<PassViewModel>();
		Navigator.of(context).push(
			MaterialPageRoute<void>(
				builder: (_) => ChangeNotifierProvider<PassViewModel>.value(
					value: passViewModel,
					child: const ActivePassScreen(),
				),
			),
		);
	}

	@override
	Widget build(BuildContext context) {
		final PassViewModel viewModel = context.watch<PassViewModel>();
		final ActivePass? activePass = viewModel.activePass;
		final Pass? activePlan = viewModel.activePassPlan;

		return Container(
			width: double.infinity,
			color: AppColors.surface,
			padding: const EdgeInsets.fromLTRB(
				AppTextStyles.spaceS + 2,
				AppTextStyles.spaceM - 4,
				AppTextStyles.spaceS + 2,
				AppTextStyles.spaceM - 4,
			),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.stretch,
				children: [
					const SizedBox(height: AppTextStyles.spaceXS - 2),
					Text(
						'Purchase a new Pass',
						textAlign: TextAlign.center,
						style: const TextStyle(
							fontSize: 23,
							fontWeight: FontWeight.w800,
							height: 1.1,
						).copyWith(color: AppColors.secondary),
					),
					const SizedBox(height: AppTextStyles.spaceXS - 2),
					Text(
						'You can only have one active pass at a time.',
						textAlign: TextAlign.center,
						style: const TextStyle(
							fontSize: 11.5,
							height: 1.2,
						).copyWith(color: AppColors.onSurfaceVariant),
					),
					const SizedBox(height: AppTextStyles.spaceM + 10),

					if (activePass != null)
						_ActivePassCard(
							activePass: activePass,
							activePlan: activePlan,
							onTapMyPass: () => _openActivePass(context),
							onCancelPass: () {
								_confirmCancelPass(context);
							},
							onExpired: () =>
									context.read<PassViewModel>().refreshPassStatus(),
						),
            const SizedBox(height: AppTextStyles.spaceS - 4),
            
					if (activePass != null) 
            const SizedBox(height: AppTextStyles.spaceS - 4),
            
					PassModeCard(
						title: PassViewModel.availablePlans[0].displayName,
						subtitle: 'Valid for ${PassViewModel.availablePlans[0].durationLabel}',
						price: PassViewModel.availablePlans[0].priceLabel,
						onTap: () => _openPassDetail(context, PassViewModel.availablePlans[0]),
					),
					const SizedBox(height: AppTextStyles.spaceS - 4),
					PassModeCard(
						title: PassViewModel.availablePlans[1].displayName,
						subtitle: 'Valid for ${PassViewModel.availablePlans[1].durationLabel}',
						price: PassViewModel.availablePlans[1].priceLabel,
						onTap: () => _openPassDetail(context, PassViewModel.availablePlans[1]),
					),
					const SizedBox(height: AppTextStyles.spaceS - 4),
					PassModeCard(
						title: PassViewModel.availablePlans[2].displayName,
						subtitle: 'Valid for ${PassViewModel.availablePlans[2].durationLabel}',
						price: PassViewModel.availablePlans[2].priceLabel,
						onTap: () => _openPassDetail(context, PassViewModel.availablePlans[2]),
					),
				],
			),
		);
	}
}

class _ActivePassCard extends StatelessWidget {
	const _ActivePassCard({
		required this.activePass,
		required this.activePlan,
		required this.onTapMyPass,
		required this.onCancelPass,
		required this.onExpired,
	});

	final ActivePass activePass;
	final Pass? activePlan;
	final VoidCallback onTapMyPass;
	final VoidCallback onCancelPass;
	final VoidCallback onExpired;

	@override
	Widget build(BuildContext context) {
		final String planName = activePlan?.displayName ?? 'Active Pass';

		return Material(
			color: AppColors.background,
			shape: RoundedRectangleBorder(
				borderRadius: BorderRadius.circular(12),
				side: BorderSide(color: AppColors.primary.withValues(alpha: 0.55), width: 1),
			),
			child: InkWell(
				onTap: onTapMyPass,
				borderRadius: BorderRadius.circular(12),
				child: Padding(
					padding: const EdgeInsets.fromLTRB(
						AppTextStyles.spaceS - 2,
						AppTextStyles.spaceS - 2,
						AppTextStyles.spaceS - 2,
						AppTextStyles.spaceXS,
					),
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							Row(
								children: [
									Expanded(
										child: Text(
											planName,
											style: const TextStyle(
												fontSize: 22,
												fontWeight: FontWeight.w800,
												color: AppColors.secondary,
											),
										),
									),
									Container(
										padding: const EdgeInsets.symmetric(
											horizontal: AppTextStyles.spaceXS - 1,
											vertical: 3,
										),
										decoration: BoxDecoration(
											color: AppColors.primary.withValues(alpha: 0.12),
											borderRadius: BorderRadius.circular(999),
											border: Border.all(
												color: AppColors.primary.withValues(alpha: 0.5),
											),
										),
										child: Row(
											mainAxisSize: MainAxisSize.min,
											children: const [
												Icon(Icons.check_circle, size: 13, color: AppColors.primary),
												SizedBox(width: 4),
												Text(
													'Active',
													style: TextStyle(
														fontSize: 11,
														fontWeight: FontWeight.w700,
														color: AppColors.primary,
													),
												),
											],
										),
									),
								],
							),
							const SizedBox(height: AppTextStyles.spaceS - 2),
							Row(
								mainAxisAlignment: MainAxisAlignment.center,
								children: [
									const Icon(Icons.access_time, size: 34, color: AppColors.onSurface),
									const SizedBox(width: AppTextStyles.spaceXS),
									Center(
										child: RemainingTime(
											expiresAt: activePass.endDate,
											onExpired: onExpired,
											style: const TextStyle(
												fontSize: 24,
												fontWeight: FontWeight.w700,
												color: Color(0xFF9A5B00),
											),
										),
									),
								],
							),
							const SizedBox(height: AppTextStyles.spaceXS),
							Center(
								child: Text(
									PassTime.formatExpiryLabel(activePass.endDate),
									textAlign: TextAlign.center,
									style: const TextStyle(
										fontSize: 15,
										color: AppColors.onSurfaceVariant,
									),
								),
							),
						],
					),
				),
			),
		);
	}
}
