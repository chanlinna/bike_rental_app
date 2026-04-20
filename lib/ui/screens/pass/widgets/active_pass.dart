import 'package:bike_rental_app/ui/screens/pass/widgets/pass_detail_block.dart';
import 'package:bike_rental_app/ui/theme/theme.dart';
import 'package:bike_rental_app/ui/utils/pass_time.dart';
import 'package:bike_rental_app/ui/utils/remaining_time.dart';
import 'package:flutter/material.dart';
import 'package:bike_rental_app/ui/screens/pass/view_model/pass_view_model.dart'
	as pass_vm;
import 'package:provider/provider.dart';


class ActivePassView extends StatelessWidget {
	const ActivePassView({super.key});

	@override
	Widget build(BuildContext context) {
		final pass_vm.PassViewModel viewModel = context.watch<pass_vm.PassViewModel>();
		final pass_vm.ActivePass? activePass = viewModel.activePass;
		final pass_vm.Pass? activePlan = viewModel.activePassPlan;

		if (activePass == null) {
			return Center(
				child: Padding(
					padding: const EdgeInsets.all(AppTextStyles.spaceM),
					child: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
							Icon(
								Icons.badge_outlined,
								size: 56,
								color: AppColors.secondary,
							),
							const SizedBox(height: AppTextStyles.spaceS),
							const Text(
								'Active Pass',
								style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
							),
							const SizedBox(height: AppTextStyles.spaceXS),
							Text(
								'No active pass yet. Purchase one from the list.',
								textAlign: TextAlign.center,
								style: TextStyle(color: AppColors.onSurfaceVariant),
							),
							const SizedBox(height: AppTextStyles.spaceS),
							TextButton(
								onPressed: () =>
										context.read<pass_vm.PassViewModel>().showAvailablePasses(),
								style: TextButton.styleFrom(
									foregroundColor: AppColors.secondary,
								),
								child: const Text('Browse passes'),
							),
						],
					),
				),
			);
		}

		final pass_vm.ActivePass currentPass = activePass;
		final String priceLabel = activePlan?.priceLabel ?? '';
		final String durationLabel = activePlan?.durationLabel ?? '';

		return Container(
			padding: const EdgeInsets.fromLTRB(
				AppTextStyles.spaceXS,
				0,
				AppTextStyles.spaceXS,
				AppTextStyles.spaceS,
			),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.stretch,
				children: [
						const SizedBox(height: AppTextStyles.spaceM),
						Text(
							priceLabel.replaceAll(' ', ''),
							textAlign: TextAlign.center,
							style: const TextStyle(
								fontSize: 48,
								fontWeight: FontWeight.w800,
								color: AppColors.onSurface,
							),
						),
						const SizedBox(height: AppTextStyles.spaceS),
						PassDetailBlock(
							title: 'Benefits:',
							child: Column(
								children: [
									BenefitRow(
										title: 'Unlimited rides',
										description: 'Take as many trips as you want',
									),
									BenefitRow(
										title: 'Valid for $durationLabel',
										description: 'From activation time',
									),
									const BenefitRow(
										title: 'Save money',
										description:
											'You could save more compared to single tickets.',
									),
								],
							),
						),
						const SizedBox(height: AppTextStyles.spaceS),
						PassDetailBlock(
							title: 'Subscription Start Date',
							child: Row(
								children: [
									Expanded(
										child: DateTimePicker(
											icon: Icons.calendar_today,
											label: PassTime.formatDate(currentPass.startDate),
										),
									),
									const SizedBox(width: AppTextStyles.spaceS - 6),
									Expanded(
										child: DateTimePicker(
											icon: Icons.access_time,
											label: PassTime.formatTime(currentPass.startDate),
										),
									),
								],
							),
						),
						const SizedBox(height: AppTextStyles.spaceS),
						Center(
							child: RemainingTime(
								expiresAt: currentPass.endDate,
								onExpired: () =>
										context.read<pass_vm.PassViewModel>().refreshPassStatus(),
								style: const TextStyle(
									fontSize: 18,
									fontWeight: FontWeight.w700,
									color: AppColors.secondary,
								),
							),
						),
						const SizedBox(height: AppTextStyles.spaceS),
				],
			),
		);
	}
}
