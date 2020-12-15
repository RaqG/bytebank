import 'package:flutter/material.dart';

import 'file:///D:/Users/raquelgallo/Documents/Flutter_Projects/bytebank/lib/screens/contacts/contacts_list.dart';

const _titleAppBar = 'Dashboard';
const _titleContact = 'Contacts';

class Dashboard extends StatelessWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleAppBar),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildLogoImage(),
          buildContactCard(context),
        ],
      ),
    );
  }

  Widget buildLogoImage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset('images/bytebank_logo.png'),
    );
  }

  Widget buildContactCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () {
            _pushScreen(context);
          },
          child: Container(
            height: 100,
            width: 160,
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.people,
                  color: Colors.white,
                  size: 24.0,
                ),
                Text(
                  _titleContact,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _pushScreen(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ContactsList()));
  }
}
