class ModelContact {
  final int id;
  final String name;
  final int accountNumber;

  ModelContact({this.id, this.name, this.accountNumber});

  factory ModelContact.fromJson(Map<String, dynamic> json) {
    return ModelContact(
      id: json['id'] != null ? json['id'] : null,
      name: json['name'] != null ? json['name'] : null,
      accountNumber: json['accountNumber'] != null
          ? json['accountNumber']
          : json['account_number'] != null
              ? json['account_number']
              : null,
    );
  }

  Map<String, dynamic> toJson(bool isContact) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) data['id'] = this.id;
    if (this.name != null) data['name'] = this.name;
    if (this.accountNumber != null && !isContact) data['accountNumber'] = this.accountNumber;
    if (this.accountNumber != null && isContact) data['account_number'] = this.accountNumber;
    return data;
  }

  @override
  String toString() {
    return 'ModelContact{name: $name, accountNumber: $accountNumber}';
  }
}
