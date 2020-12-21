import 'package:bytebank/bytebank.dart';
import 'package:flutter/material.dart';

const String _titleAppBar = 'Contacts';
const String _errorMessage = 'Unknown Error';

class ContactsList extends StatefulWidget {
  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleAppBar),
      ),
      body: FutureBuilder<List<ModelContact>>(
        initialData: [],
        future: _dao.findAll(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              List<ModelContact> contacts = snapshot.data;
              return ListView.builder(
                itemCount: contacts.length != null ? contacts.length : 0,
                itemBuilder: (context, index) {
                  final ModelContact contact = contacts[index];
                  return ContactItem(
                    contact: contact,
                    onPushScreen: (screen) =>
                        _pushScreen(context, screen, contact: contact),
                    onDelete: () => _onDeleteContact(contact),
                  );
                },
              );
          }
          return Text(_errorMessage);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _pushScreen(context, ContactForm()),
        child: Icon(Icons.add),
      ),
    );
  }

  void _pushScreen(context, screen, {ModelContact contact}) {
    final response = Navigator.push(
        context, MaterialPageRoute(builder: (context) => screen));
    response.then((value) {
      setState(() {});
    }).catchError((e) => debugPrint("ERROR: ${e.message}"));
  }

  _onDeleteContact(ModelContact contact) {
    _dao.delete(contact.id);
    setState(() {});
  }
}
