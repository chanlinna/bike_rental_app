enum PassType { daily, weekly, monthly }

class Pass {
  final String passId;
  final PassType passType;
  final double price;

  Pass({required this.passId, required this.passType, required this.price});
}
