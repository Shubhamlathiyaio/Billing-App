class Invoice {
  String companyName;
  String companyAddress;
  String gstNumber;
  String panNumber;
  String stateCode;
  String bankName;
  String branch;
  String accountNumber;
  String ifsc;
  String termsAndConditions;
  
  Invoice({
    required this.companyName,
    required this.companyAddress,
    required this.gstNumber,
    required this.panNumber,
    required this.stateCode,
    required this.bankName,
    required this.branch,
    required this.accountNumber,
    required this.ifsc,
    required this.termsAndConditions,
  });

  // Convert to JSON for local storage
  Map<String, dynamic> toJson() => {
        "companyName": companyName,
        "companyAddress": companyAddress,
        "gstNumber": gstNumber,
        "panNumber": panNumber,
        "stateCode": stateCode,
        "bankName": bankName,
        "branch": branch,
        "accountNumber": accountNumber,
        "ifsc": ifsc,
        "termsAndConditions": termsAndConditions,
      };

  // Convert from JSON
  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        companyName: json["companyName"] ?? "",
        companyAddress: json["companyAddress"] ?? "",
        gstNumber: json["gstNumber"] ?? "",
        panNumber: json["panNumber"] ?? "",
        stateCode: json["stateCode"] ?? "",
        bankName: json["bankName"] ?? "",
        branch: json["branch"] ?? "",
        accountNumber: json["accountNumber"] ?? "",
        ifsc: json["ifsc"] ?? "",
        termsAndConditions: json["termsAndConditions"] ?? "",
      );
}
