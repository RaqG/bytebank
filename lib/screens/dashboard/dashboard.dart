import 'package:bytebank/bytebank.dart';
import 'package:flutter/material.dart';

const _titleAppBar = 'Dashboard';
const _titleContact = 'Contacts';
const _titleTransfer = 'Transfer';
const _titleTransactionFeed = 'Transaction Feed';

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
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                FeatureItem(
                  title: _titleTransfer,
                  icon: Icons.monetization_on_outlined,
                  onPushScreen: () => _pushScreen(context, ContactsList()),
                ),
                FeatureItem(
                  title: _titleTransactionFeed,
                  icon: Icons.description,
                  onPushScreen: () => _pushScreen(context, TransactionsList()),
                ),
              ],
            ),
          ),
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

  _pushScreen(context, screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}
