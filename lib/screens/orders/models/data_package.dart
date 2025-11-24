enum PackageStatus { delivered, inProgress, failed }

class DataPackage {
  final String title;
  final String code;
  final double amountPaid;
  final PackageStatus status;
  final DateTime time;

  DataPackage({
    required this.title,
    required this.code,
    required this.amountPaid,
    required this.status,
    required this.time,
  });
}
