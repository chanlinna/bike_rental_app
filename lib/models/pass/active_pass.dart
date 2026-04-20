class ActivePass {
  final String passId;
  final DateTime startDate;
  final DateTime endDate;

  ActivePass({
    required this.passId,
    required this.startDate,
    required this.endDate,
  });

  DateTime get purchasedAt => startDate;
  DateTime get expiresAt => endDate;
}

