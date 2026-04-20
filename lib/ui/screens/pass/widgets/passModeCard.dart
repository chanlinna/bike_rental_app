import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

class PassModeCard extends StatelessWidget {
	const PassModeCard({
		super.key,
		required this.title,
		required this.subtitle,
		required this.price,
		this.onTap,
	});

	final String title;
	final String subtitle;
	final String price;
	final VoidCallback? onTap;

	@override
	Widget build(BuildContext context) {
		return Material(
			color: AppColors.surface,
			shape: RoundedRectangleBorder(
				borderRadius: BorderRadius.circular(12),
				side: BorderSide(color: AppColors.outline, width: 1.1),
			),
			child: InkWell(
				onTap: onTap,
				borderRadius: BorderRadius.circular(12),
				child: Padding(
					padding: const EdgeInsets.symmetric(
						horizontal: AppTextStyles.spaceS - 2,
						vertical: AppTextStyles.spaceS - 2,
					),
					child: Row(
						children: [
							Expanded(
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									mainAxisSize: MainAxisSize.min,
									children: [
										Text(
											title,
											style: TextStyle(
												fontSize: 20,
												fontWeight: FontWeight.w700,
												color: AppColors.secondary,
												height: 1.1,
											),
										),
										const SizedBox(height: AppTextStyles.spaceXS * 0.5),
										Text(
											subtitle,
											style: TextStyle(
												fontSize: 12.5,
												fontWeight: FontWeight.w400,
												color: AppColors.onSurfaceVariant,
												height: 1.15,
											),
										),
									],
								),
							),
							Container(
								height: 44,
								width: 1,
								margin: const EdgeInsets.symmetric(horizontal: 12),
								color: AppColors.outlineVariant,
							),
							Row(
								mainAxisSize: MainAxisSize.min,
								children: [
									Text(
										price,
										style: TextStyle(
											fontSize: 19,
											fontWeight: FontWeight.w800,
											color: AppColors.onSurface,
											height: 1.0,
										),
									),
									const SizedBox(width: AppTextStyles.spaceS - 6),
									Icon(
										Icons.chevron_right,
										size: 26,
										color: AppColors.secondary,
									),
								],
							),
						],
					),
				),
			),
		);
	}
}
