class TableItem {
  int chalanNo; // ✅ New field
  String itemName;
  double quality;
  double quantity;
  double rate;

  TableItem({
    required this.chalanNo,
    required this.itemName,
    required this.quality,
    required this.quantity,
    required this.rate,
  });

  Map<String, dynamic> toJson() => {
        'chalanNo': chalanNo,
        'itemName': itemName,
        'quality': quality,
        'qty': quantity,
        'rate': rate,
      };

  factory TableItem.fromJson(Map<String, dynamic> json) => TableItem(
        chalanNo: json['chalanNo'] ?? '',
        itemName: json['itemName'],
        quality: json['quality'],
        quantity: json['qty'],
        rate: json['rate'],
      );
}
