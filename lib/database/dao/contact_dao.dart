import 'dart:async';

import 'package:bytebank/database//app_database.dart';
import 'package:bytebank/models/contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactDao {
  static const String tableSQL = 'CREATE TABLE $_tableName'
      '($_columnId INTEGER PRIMARY KEY, $_columnName TEXT, $_columnAccountNumber INTEGER)';
  static const String _tableName = 'contacts';
  static const String _columnId = 'id';
  static const String _columnName = 'name';
  static const String _columnAccountNumber = 'account_number';

  Future<int> save(ModelContact contact) async {
    /// Async-Await
    final Database db = await getDatabase();
    Map<String, dynamic> contactMap = _toMap(contact);
    return db.insert(_tableName, contactMap);

    /// .then()
    // getDatabase().then((db) {
    //   final Map<String, dynamic> contactMap = Map();
    //   contactMap['name'] = contact.name;
    //   contactMap['account_number'] = contact.accountNumber;
    //   return db.insert('contacts', contactMap);
    // });
  }

  Future<List<ModelContact>> findAll() async {
    /// Async-Await
    final Database db = await getDatabase();
    List<Map<String, dynamic>> result = await db.query(_tableName);
    List<ModelContact> contacts = _toList(result);
    return contacts;

    /// .then()
    // return getDatabase().then((db) {
    //   return db.query('contacts').then((maps) {
    //     final List<ModelContact> contacts = List();
    //     for (Map<String, dynamic> map in maps) {
    //       final ModelContact contact = ModelContact(
    //         map['id'],
    //         map['name'],
    //         map['account_number'],
    //       );
    //       contacts.add(contact);
    //     }
    //     return contacts;
    //   });
    // });
  }

  Future<int> update(ModelContact contact, int contactId) async {
    final Database db = await getDatabase();
    return db.update(
      _tableName,
      _toMap(contact),
      where: '$_columnId = ?',
      whereArgs: [contactId],
    );
  }

  Future<int> delete(int contactId) async {
    final Database db = await getDatabase();
    return db.delete(
      _tableName,
      where: '$_columnId = ?',
      whereArgs: [contactId],
    );
  }

  Map<String, dynamic> _toMap(ModelContact contact) {
    final Map<String, dynamic> contactMap = Map();
    contactMap[_columnName] = contact.name;
    contactMap[_columnAccountNumber] = contact.accountNumber;
    return contactMap;
  }

  List<ModelContact> _toList(List<Map<String, dynamic>> result) {
    final List<ModelContact> contacts = List();
    for (Map<String, dynamic> row in result) {
      final ModelContact contact = ModelContact(
        row[_columnId],
        row[_columnName],
        row[_columnAccountNumber],
      );
      contacts.add(contact);
    }
    return contacts;
  }
}
