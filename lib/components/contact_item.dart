import 'package:bytebank/bytebank.dart';
import 'package:flutter/material.dart';

const String _editContact = 'Edit contact';
const String _deleteContact = 'Delete contact';
const String _createTransaction = 'Create transaction';
const String _alertTitle = 'Choose an option';

class ContactItem extends StatelessWidget {
  final ModelContact contact;
  final Function onPushScreen;
  final Function onDelete;

  const ContactItem({
    Key key,
    this.contact,
    this.onPushScreen,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(contact.name),
        subtitle: Text("${contact.accountNumber}"),
        onTap: () {
          _showDialogMenu(context);
        },
      ),
    );
  }

  void _showDialogMenu(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => SimpleDialog(
        title: Text(_alertTitle),
        children: [
          SimpleDialogItem(
            icon: Icons.monetization_on_outlined,
            iconColor: Colors.green,
            itemName: _createTransaction,
            onClick: () => onPushScreen(TransactionForm(contact: contact)),
          ),
          SimpleDialogItem(
            icon: Icons.edit_outlined,
            iconColor: Colors.grey,
            itemName: _editContact,
            onClick: () => onPushScreen(ContactForm(contact: contact)),
          ),
          SimpleDialogItem(
            icon: Icons.delete_outline,
            iconColor: Colors.red,
            itemName: _deleteContact,
            onClick: () => onDelete(),
          ),
        ],
      ),
    );
  }
}
