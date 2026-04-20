enum PassType { daily, weekly, monthly }

class Pass {
  final String passId;
  final PassType passType;
  final double price;

  Pass({required this.passId, required this.passType, required this.price});

  String get displayName => switch (passType) {
    PassType.daily => 'Daily Pass',
    PassType.weekly => 'Weekly Pass',
    PassType.monthly => 'Monthly Pass',
  };

  String get durationLabel => switch (passType) {
    PassType.daily => '24 hours',
    PassType.weekly => '7 days',
    PassType.monthly => '30 days',
  };

  Duration get period => switch (passType) {
    PassType.daily => const Duration(hours: 24),
    PassType.weekly => const Duration(days: 7),
    PassType.monthly => const Duration(days: 30),
  };

  String get priceLabel => '\$ ${price.toStringAsFixed(2)}';
}
