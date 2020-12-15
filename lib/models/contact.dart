class ModelContact {
  final int id;
  final String name;
  final int accountNumber;

  ModelContact(this.id, this.name, this.accountNumber);

  @override
  String toString() {
    return 'ModelContact{name: $name, accountNumber: $accountNumber}';
  }
}
