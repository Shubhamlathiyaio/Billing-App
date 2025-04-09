class TableItem {
  final String description;
  final String quality;
  final String hsnCode;
  final double qty;
  final double rate;
  final double amount;

  TableItem({
    required this.description,
    required this.quality,
    required this.hsnCode,
    required this.qty,
    required this.rate,
  }) : amount = qty * rate;

  Map<String, dynamic> toJson() => {
        'description': description,
        'quality': quality,
        'hsnCode': hsnCode,
        'qty': qty,
        'rate': rate,
        'amount': amount,
      };

  factory TableItem.fromJson(Map<String, dynamic> json) => TableItem(
        description: json['description'],
        quality: json['quality'],
        hsnCode: json['hsnCode'],
        qty: json['qty'],
        rate: json['rate'],
      );
}
