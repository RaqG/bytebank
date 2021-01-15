import 'package:bytebank/models/contact.dart';

class ModelTransaction {
  String id;
  double value;
  ModelContact contact;
  String dateTime;

  ModelTransaction({
    this.contact,
    this.dateTime,
    this.id,
    this.value,
  }) : assert(value > 0);

  factory ModelTransaction.fromJson(Map<String, dynamic> json) {
    return ModelTransaction(
      contact: json['contact'] != null
          ? ModelContact.fromJson(json['contact'])
          : null,
      dateTime: json['dateTime'] != null ? json['dateTime'] : null,
      id: json['id'] != null ? json['id'] : null,
      value: json['value'] != null ? json['value'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dateTime'] = this.dateTime;
    data['id'] = this.id;
    data['value'] = this.value;
    if (this.contact != null) {
      data['contact'] = this.contact.toJson(false);
    }
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelTransaction &&
          runtimeType == other.runtimeType &&
          value == other.value &&
          contact == other.contact;

  @override
  int get hashCode => value.hashCode ^ contact.hashCode;
}
