class TableItem {
  int chalanNo;
  String itemName;
  String taka;
  String hsnCode; // ✅ New nullable field
  double qty;
  double rate;

  TableItem({
    required this.chalanNo,
    required this.itemName,
    required this.taka,
    required this.hsnCode, // ✅ Optional
    required this.qty,
    required this.rate,
  });

  Map<String, String> toJson() => {
        'chalanNo': chalanNo.toString(),
        'itemName': itemName,
        'taka': taka,
        'hsnCode': hsnCode, // ✅ Save it
        'qty': qty.toString(),
        'rate': rate.toString(),
      };

  factory TableItem.fromJson(Map<String, dynamic> json) => TableItem(
        chalanNo: int.parse(json['chalanNo']),
        itemName: json['itemName'],
        taka: json['taka'],
        hsnCode: json['hsnCode'], // ✅ Load it
        qty: double.parse(json['qty'],),
        rate: double.parse(json['rate']),
      );
}
