import 'package:bytebank/components/confirm_button.dart';
import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/service/web_clients/transaction_web_client.dart';
import 'package:flutter/material.dart';

const String _titleAppBar = 'New transaction';
const String _buttonText = 'Transfer';
const _valueLabelText = 'Value';
const _valueHintText = 'Ex.: 125.67';

class TransactionForm extends StatefulWidget {
  final ModelContact contact;

  const TransactionForm({Key key, this.contact}) : super(key: key);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                '${widget.contact.name} - ${widget.contact.accountNumber}',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Editor(
              controller: _valueController,
              labelText: _valueLabelText,
              hintText: _valueHintText,
              textInputType: TextInputType.number,
            ),
            ConfirmButton(
              buttonText: _buttonText,
              onPressed: () => _onPressed(),
            )
          ],
        ),
      ),
    );
  }

  _onPressed() {
    final double value = double.tryParse(_valueController.text);
    final transactionCreated = ModelTransaction(
      value: value,
      contact: widget.contact,
    );
    webClient.save(transactionCreated).then((transaction) {
      if (transaction != null) {
        Navigator.pop(context);
      }
    });
  }
}
