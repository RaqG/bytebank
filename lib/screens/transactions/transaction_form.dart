import 'dart:async';

import 'package:bytebank/bytebank.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const _titleAppBar = 'New transaction';
const _buttonTransferText = 'Transfer';
const _sendingText = 'Sending...';
const _successfulMessage = 'Successful transaction';
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
  final String transactionId = Uuid().v4();

  bool _sending = false;

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
            if (_sending) _showSendingProgress(),
            _showContactInfo(),
            Editor(
              controller: _valueController,
              labelText: _valueLabelText,
              hintText: _valueHintText,
              textInputType: TextInputType.number,
            ),
            ConfirmButton(
              buttonText: _sending ? _sendingText : _buttonTransferText,
              onPressed: () => _onPressed(),
              isDisable: _sending,
            )
          ],
        ),
      ),
    );
  }

  Padding _showContactInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        '${widget.contact.name} - ${widget.contact.accountNumber}',
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Padding _showSendingProgress() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Progress(
        message: _sendingText,
      ),
    );
  }

  _onPressed() {
    final double value = double.tryParse(_valueController.text);
    final transactionCreated = ModelTransaction(
      id: transactionId,
      value: value,
      contact: widget.contact,
    );

    openAuthDialog(transactionCreated);
  }

  _onConfirm(ModelTransaction transactionCreated, String password) async {
    setState(() {
      _sending = true;
    });

    final ModelTransaction transaction = await webClient
        .save(transactionCreated, password)
        .catchError((e) => openFailureDialog(e.message),
            test: (e) => e is TimeoutException)
        .catchError((e) => openFailureDialog(e.message),
            test: (e) => e is HttpException)
        .whenComplete(() => setState(() => _sending = false));

    if (transaction != null) {
      openSuccessfulDialog();
    }
  }

  void openAuthDialog(ModelTransaction transactionCreated) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (contextDialog) {
          return AuthDialog(
            onConfirm: (password) => _onConfirm(transactionCreated, password),
          );
        });
  }

  void openSuccessfulDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (contextDialog) {
          return SuccessDialog(message: _successfulMessage);
        }).then((value) => Navigator.pop(context));
  }

  void openFailureDialog(String error) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (contextDialog) {
          return FailureDialog(message: error);
        });
  }
}
