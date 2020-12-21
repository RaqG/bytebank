import 'package:bytebank/bytebank.dart';
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

  const ContactForm({Key key, this.contact}) : super(key: key);

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _fullNameTextController = TextEditingController();
  final TextEditingController _accountNumberTextController =
      TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final ContactDao _dao = ContactDao();
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
              onPressed: () => _createUpdateContact(),
            ),
          ],
        ),
      ),
    );
  }

  _createUpdateContact() {
    final String fullName = _fullNameTextController.text;
    final int accountNumber = int.tryParse(_accountNumberTextController.text);
    if (fullName != null && accountNumber != null) {
      final ModelContact newContact =
          ModelContact(id: 0, name: fullName, accountNumber: accountNumber);
      isEdit ? updateContact(newContact) : saveContact(newContact);
    } else {
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(_errorMessage)));
    }
  }

  Future<Function> saveContact(ModelContact newContact) =>
      _dao.save(newContact).then((id) => _navigatorPop());

  Future<Function> updateContact(ModelContact newContact) {
    return _dao
        .update(newContact, widget.contact.id)
        .then((id) => _navigatorPop());
  }

  _navigatorPop() {
    return Navigator.pop(context);
  }
}
