import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

class PassDetailBlock extends StatelessWidget {
	const PassDetailBlock({
		super.key,
		required this.title,
		required this.child,
		this.scale = 1,
	});

	final String title;
	final Widget child;
	final double scale;

	@override
	Widget build(BuildContext context) {
		return Container(
			width: double.infinity,
			padding: EdgeInsets.all(14 * scale),
			decoration: BoxDecoration(
				color: AppColors.surfaceVariant.withValues(alpha: 0.45),
				borderRadius: BorderRadius.circular(14 * scale),
				border: Border.all(color: AppColors.outlineVariant),
			),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Text(
						title,
						style: TextStyle(
							fontSize: 16 * scale,
							fontWeight: FontWeight.w700,
							color: AppColors.onSurface,
						),
					),
					SizedBox(height: AppTextStyles.spaceS * 0.75 * scale),
					child,
				],
			),
		);
	}
}

class BenefitRow extends StatelessWidget {
	const BenefitRow({
		super.key,
		required this.title,
		required this.description,
		this.scale = 1,
	});

	final String title;
	final String description;
	final double scale;

	@override
	Widget build(BuildContext context) {
		return Padding(
			padding: EdgeInsets.only(bottom: 10 * scale),
			child: Row(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Container(
						margin: EdgeInsets.only(top: 2 * scale),
						height: 18 * scale,
						width: 18 * scale,
						decoration: BoxDecoration(
							shape: BoxShape.circle,
							color: AppColors.primary,
						),
						child: Icon(Icons.check, color: Colors.white, size: 12 * scale),
					),
					SizedBox(width: AppTextStyles.spaceXS * scale),
					Expanded(
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								Text(
									title,
									style: TextStyle(
										fontSize: 14.5 * scale,
										fontWeight: FontWeight.w700,
										color: AppColors.onSurface,
									),
								),
								SizedBox(height: 2 * scale),
								Text(
									description,
									style: TextStyle(
										fontSize: 12 * scale,
										color: AppColors.onSurfaceVariant,
										height: 1.25,
									),
								),
							],
						),
					),
				],
			),
		);
	}
}

class DateTimePicker extends StatelessWidget {
	const DateTimePicker({
		super.key,
		required this.icon,
		required this.label,
		this.onTap,
		this.scale = 1,
	});

	final IconData icon;
	final String label;
	final VoidCallback? onTap;
	final double scale;

	@override
	Widget build(BuildContext context) {
		final bool isInteractive = onTap != null;

		return Material(
			color: Colors.transparent,
			child: InkWell(
				onTap: onTap,
				borderRadius: BorderRadius.circular(10 * scale),
				child: Container(
					padding: EdgeInsets.symmetric(
						horizontal: 12 * scale,
						vertical: 9 * scale,
					),
					decoration: BoxDecoration(
						color: isInteractive
								? AppColors.primary.withValues(alpha: 0.08)
								: AppColors.surfaceVariant.withValues(alpha: 0.5),
						borderRadius: BorderRadius.circular(10 * scale),
						border: Border.all(
							color: isInteractive
									? AppColors.primary.withValues(alpha: 0.45)
									: AppColors.outlineVariant,
						),
					),
					child: Row(
						mainAxisSize: MainAxisSize.min,
						children: [
							Icon(icon, size: 14 * scale, color: AppColors.primary),
							SizedBox(width: 6 * scale),
							Expanded(
								child: Text(
									label,
									overflow: TextOverflow.ellipsis,
									style: TextStyle(
										fontSize: 13 * scale,
										fontWeight: FontWeight.w600,
										color: AppColors.onSurface,
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
