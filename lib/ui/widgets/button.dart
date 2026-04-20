import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
	const PrimaryButton({
		super.key,
		required this.text,
		required this.callback,
		this.height = 46,
		this.backgroundColor,
		this.textStyle,
	});

	final String text;
	final VoidCallback callback;
	final double height;
	final Color? backgroundColor;
	final TextStyle? textStyle;

	@override
	Widget build(BuildContext context) {
		final Color resolvedBackgroundColor =
				backgroundColor ?? Theme.of(context).colorScheme.primary;
		final Color resolvedForegroundColor = Theme.of(context).colorScheme.onPrimary;

		return SizedBox(
			width: double.infinity,
			height: height,
			child: ElevatedButton(
				onPressed: callback,
				style: ElevatedButton.styleFrom(
					backgroundColor: resolvedBackgroundColor,
					foregroundColor: resolvedForegroundColor,
				),
				child: Text(text, style: textStyle),
			),
		);
	}
}
