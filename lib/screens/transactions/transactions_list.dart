import 'package:bytebank/bytebank.dart';
import 'package:flutter/material.dart';

const String _titleAppBar = 'Transactions';
const String _unknownMessage = 'Unknown error';
const String _emptyMessage = 'No transactions found';

class TransactionsList extends StatefulWidget {
  @override
  _TransactionsListState createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  final TransactionWebClient webClient = TransactionWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleAppBar),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return FutureBuilder<List<ModelTransaction>>(
        initialData: [],
        future: webClient.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                final List<ModelTransaction> transactions = snapshot.data ?? [];
                if (transactions.isNotEmpty) return buildList(transactions);

                return ErrorMessage(
                  message: _emptyMessage,
                  icon: Icons.warning,
                );
              } else {
                return ErrorMessage(message: snapshot.error.toString());
              }
          }
          return ErrorMessage(message: _unknownMessage);
        });
  }

  Widget buildList(List<ModelTransaction> transactions) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final ModelTransaction transaction = transactions[index];
        return Card(
          child: ListTile(
            leading: Icon(Icons.monetization_on),
            title: Text(
              transaction.value.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              transaction.contact.accountNumber.toString(),
            ),
          ),
        );
      },
      itemCount: transactions?.length != null ? transactions?.length : 0,
    );
  }
}
