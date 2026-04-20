import 'package:flutter/material.dart';
import 'package:bike_rental_app/ui/screens/pass/pass_purchase_success_screen.dart';
import 'package:bike_rental_app/ui/screens/pass/view_model/pass_view_model.dart';
import 'package:bike_rental_app/ui/screens/pass/widgets/pass_detail_block.dart';
import 'package:provider/provider.dart';

import '../../theme/theme.dart';
import 'package:bike_rental_app/ui/widgets/button.dart';

class PassDetailScreen extends StatefulWidget {
	const PassDetailScreen({super.key, required this.plan});

	final Pass plan;

	@override
	State<PassDetailScreen> createState() => _PassDetailScreenState();
}

class _PassDetailScreenState extends State<PassDetailScreen> {
	late DateTime _selectedStartDateTime;

	DateTime _dateOnly(DateTime value) {
		return DateTime(value.year, value.month, value.day);
	}

	DateTime _truncateToMinute(DateTime value) {
		return DateTime(
			value.year,
			value.month,
			value.day,
			value.hour,
			value.minute,
		);
	}

	void _showPastTimeMessage() {
		ScaffoldMessenger.of(context).showSnackBar(
			const SnackBar(
				content: Text('Past time is not allowed for today.'),
			),
		);
	}

	@override
	void initState() {
		super.initState();
		_selectedStartDateTime = DateTime.now();
	}

	Future<void> _pickDate() async {
		final DateTime now = DateTime.now();
		final DateTime today = _dateOnly(now);
		final DateTime firstDate = today;
		final DateTime lastDate = DateTime(now.year + 2, 12, 31);
		final DateTime initialDate = _selectedStartDateTime.isBefore(today)
				? today
				: _selectedStartDateTime;

		final DateTime? pickedDate = await showDatePicker(
			context: context,
			initialDate: initialDate,
			firstDate: firstDate,
			lastDate: lastDate,
		);

		if (pickedDate == null || !mounted) {
			return;
		}

		DateTime nextDateTime = DateTime(
			pickedDate.year,
			pickedDate.month,
			pickedDate.day,
			_selectedStartDateTime.hour,
			_selectedStartDateTime.minute,
		);

		final DateTime nowMinute = _truncateToMinute(now);
		final bool isToday = _dateOnly(nextDateTime) == today;
		if (isToday && nextDateTime.isBefore(nowMinute)) {
			nextDateTime = nowMinute;
		}

		setState(() {
			_selectedStartDateTime = nextDateTime;
		});
	}

	Future<void> _pickTime() async {
		final TimeOfDay initialTime = TimeOfDay.fromDateTime(_selectedStartDateTime);
		final TimeOfDay? pickedTime = await showTimePicker(
			context: context,
			initialTime: initialTime,
		);

		if (pickedTime == null || !mounted) {
			return;
		}

		final DateTime candidate = DateTime(
			_selectedStartDateTime.year,
			_selectedStartDateTime.month,
			_selectedStartDateTime.day,
			pickedTime.hour,
			pickedTime.minute,
		);
		final DateTime now = DateTime.now();
		final DateTime nowMinute = _truncateToMinute(now);
		final bool isToday = _dateOnly(candidate) == _dateOnly(now);
		if (isToday && candidate.isBefore(nowMinute)) {
			_showPastTimeMessage();
			return;
		}

		setState(() {
			_selectedStartDateTime = candidate;
		});
	}

	@override
	Widget build(BuildContext context) {
		final double width = MediaQuery.sizeOf(context).width;
		final double scale = (width / 390).clamp(0.85, 1.0);
		final bool canPurchase = !context.watch<PassViewModel>().hasActivePass;
		final MaterialLocalizations l10n = MaterialLocalizations.of(context);
		final String dateLabel = l10n.formatMediumDate(_selectedStartDateTime);
		final String timeLabel = l10n.formatTimeOfDay(
			TimeOfDay.fromDateTime(_selectedStartDateTime),
			alwaysUse24HourFormat: false,
		);

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
					widget.plan.displayName,
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
							child: SingleChildScrollView(
								padding: EdgeInsets.fromLTRB(
									12 * scale,
									12 * scale,
									12 * scale,
									20 * scale,
								),
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.stretch,
									children: [
										Text(
											widget.plan.priceLabel.replaceAll(' ', ''),
											textAlign: TextAlign.center,
											style: TextStyle(
												fontSize: 60 * scale,
												fontWeight: FontWeight.w800,
												color: AppColors.onSurface,
											),
										),
										SizedBox(height: 16 * scale),
										PassDetailBlock(
											title: 'Benefits:',
											scale: scale,
											child: Column(
												children: [
													BenefitRow(
														title: 'Unlimited rides',
														description: 'Take as many trips as you want',
														scale: scale,
													),
													BenefitRow(
														title: 'Valid for ${widget.plan.durationLabel}',
														description: 'From activation time',
														scale: scale,
													),
													BenefitRow(
														title: 'Save money',
														description:
															'You could save more compared to single tickets.',
														scale: scale,
													),
												],
											),
										),
										SizedBox(height: 16 * scale),
										PassDetailBlock(
											title: 'Subscription Start Date',
											scale: scale,
											child: Column(
												crossAxisAlignment: CrossAxisAlignment.stretch,
												children: [
													Row(
														children: [
															Expanded(
																child: DateTimePicker(
																	icon: Icons.calendar_today,
																	label: dateLabel,
																	onTap: _pickDate,
																	scale: scale,
																),
															),
															SizedBox(width: 10 * scale),
															Expanded(
																child: DateTimePicker(
																	icon: Icons.access_time,
																	label: timeLabel,
																	onTap: _pickTime,
																	scale: scale,
																),
															),
														],
													),
													SizedBox(height: 8 * scale),
													if (!canPurchase) ...[
														SizedBox(height: 8 * scale),
														Text(
															'You already have an active pass. Cancel or wait for expiry to buy this plan.',
															textAlign: TextAlign.center,
															style: TextStyle(
																fontSize: 12 * scale,
																color: AppColors.onSurfaceVariant,
															),
														),
													],
												],
											),
										),
									],
								),
							),
						),
						Container(
							padding: EdgeInsets.fromLTRB(
								12 * scale,
								10 * scale,
								12 * scale,
								(AppTextStyles.spaceS + 2) * scale,
							),
							decoration: BoxDecoration(
								color: AppColors.surface,
								border: Border(
									top: BorderSide(color: AppColors.outlineVariant),
								),
							),
							child: PrimaryButton(
								text: canPurchase ? 'Purchase' : 'Back',
								callback: () {
									if (!canPurchase) {
										Navigator.of(context).pop();
										return;
									}

									final PurchaseResult result =
											context.read<PassViewModel>().purchase(widget.plan);
									if (result == PurchaseResult.success) {
										Navigator.of(context).pushReplacement(
											MaterialPageRoute<void>(
												builder: (_) => PassPurchaseSuccessScreen(),
											),
										);
										return;
									}

									showDialog<void>(
										context: context,
										builder: (context) {
											return AlertDialog(
												title: const Text('Purchase blocked'),
												content: const Text(
													'You already have an active pass. Please wait until it expires.',
												),
												actions: [
													TextButton(
														onPressed: () => Navigator.of(context).pop(),
														child: const Text('OK'),
													),
												],
											);
										},
									);
								},
								backgroundColor:
										canPurchase ? AppColors.primary : AppColors.disabled,
								height: 46 * scale,
								textStyle: TextStyle(
									fontSize: 15 * scale,
									fontWeight: FontWeight.w700,
								),
							),
						),
					],
				),
			),
		);
	}
}
