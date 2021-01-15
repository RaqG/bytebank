import 'dart:async';

import 'package:bytebank/bytebank.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

const _errorMessage = 'Reveja os dados informados no formulário';
const _newContactAppBar = 'New contact';
const _editContactAppBar = 'Edit contact';
const _editButton = 'Update';
const _saveButton = 'Create';
const _nameLabelText = 'Full name';
const _nameHintText = 'Ex.: Raquel';
const _accountLabelText = 'Account number';
const _accountHintText = 'Ex.: 083274';

class ContactForm extends StatefulWidget {
  final ModelContact contact;

  const ContactForm({
    Key key,
    this.contact,
  }) : super(key: key);

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _fullNameTextController = TextEditingController();
  final TextEditingController _accountNumberTextController =
      TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isEdit = false;

  @override
  void initState() {
    if (widget.contact != null) {
      isEdit = true;
      _accountNumberTextController.text =
          widget.contact.accountNumber.toString();
      _fullNameTextController.text = widget.contact.name;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppDependencies dependencies = AppDependencies.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(isEdit ? _editContactAppBar : _newContactAppBar),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Editor(
              controller: _fullNameTextController,
              labelText: _nameLabelText,
              hintText: _nameHintText,
            ),
            Editor(
              controller: _accountNumberTextController,
              labelText: _accountLabelText,
              hintText: _accountHintText,
              textInputType: TextInputType.number,
            ),
            ConfirmButton(
              buttonText: isEdit ? _editButton : _saveButton,
              onPressed: () => _createUpdateContact(dependencies.contactDao),
            ),
          ],
        ),
      ),
    );
  }

  _createUpdateContact(ContactDao contactDao) {
    final int contactId = widget?.contact?.id ?? null;
    final String fullName = _fullNameTextController.text;
    final int accountNumber = int.tryParse(_accountNumberTextController.text);
    if (fullName != null && accountNumber != null) {
      final ModelContact newContact = ModelContact(
          id: contactId, name: fullName, accountNumber: accountNumber);
      isEdit
          ? updateContact(newContact, contactDao)
          : saveContact(newContact, contactDao);
    } else {
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(_errorMessage)));
    }
  }

  FutureOr<void> saveContact(
      ModelContact newContact, ContactDao contactDao) async {
    await contactDao.save(newContact);
    _navigatorPop();
  }

  FutureOr<void> updateContact(
      ModelContact newContact, ContactDao contactDao) async {
    await contactDao.update(newContact, widget.contact.id);
    _navigatorPop();
  }

  _navigatorPop() {
    return Navigator.pop(context);
  }
}
