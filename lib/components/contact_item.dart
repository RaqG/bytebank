import 'package:bytebank/components/simple_dialog_item.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter/material.dart';

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
        title: Text('Choose an option'),
        children: [
          SimpleDialogItem(
            icon: Icons.edit_outlined,
            iconColor: Colors.grey,
            itemName: 'Edit',
            onClick: () => onPushScreen(),
          ),
          SimpleDialogItem(
            icon: Icons.delete_outline,
            iconColor: Colors.red,
            itemName: 'Delete',
            onClick: () => onDelete(),
          ),
        ],
      ),
    );
  }
}
