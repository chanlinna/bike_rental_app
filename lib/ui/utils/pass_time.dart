
class PassTime {
	const PassTime._();

	static String formatRemaining(Duration remaining) {
		if (remaining.isNegative || remaining.inSeconds <= 0) {
			return 'Expired';
		}

		final int hours = remaining.inHours;
		final int minutes = remaining.inMinutes.remainder(60);
		return '${hours}h ${minutes}mn left';
	}

	static String formatDate(DateTime dateTime) {
		const List<String> months = <String>[
			'Jan',
			'Feb',
			'Mar',
			'Apr',
			'May',
			'Jun',
			'Jul',
			'Aug',
			'Sep',
			'Oct',
			'Nov',
			'Dec',
		];

		final String month = months[dateTime.month - 1];
		return '$month ${dateTime.day}, ${dateTime.year}';
	}

	static String formatTime(DateTime dateTime) {
		final int hour12 = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
		final String minute = dateTime.minute.toString().padLeft(2, '0');
		final String meridiem = dateTime.hour >= 12 ? 'PM' : 'AM';
		return '$hour12:$minute $meridiem';
	}

	static String formatExpiryLabel(DateTime expiresAt, {DateTime? now}) {
		final DateTime current = now ?? DateTime.now();
		final DateTime today = DateTime(current.year, current.month, current.day);
		final DateTime date = DateTime(expiresAt.year, expiresAt.month, expiresAt.day);

		if (date == today) {
			return 'Expires today at ${formatTime(expiresAt)}';
		}

		if (date == today.add(const Duration(days: 1))) {
			return 'Expires tomorrow at ${formatTime(expiresAt)}';
		}

		return 'Expires on ${formatDate(expiresAt)} at ${formatTime(expiresAt)}';
	}
}
