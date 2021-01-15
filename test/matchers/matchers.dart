import 'package:bytebank/bytebank.dart';
import 'package:flutter/material.dart';

bool featureItemMatcher(Widget widget, String name, IconData icon) {
  if (widget is FeatureItem) {
    return widget.title == name && widget.icon == icon;
  }
  return false;
}

bool contactItemMatcher(Widget widget, String name, int accountNumber) {
  if (widget is ContactItem) {
    return widget.contact.name == name &&
        widget.contact.accountNumber == accountNumber;
  }
  return false;
}

bool simpleDialogItemMatcher(Widget widget, IconData icon, String itemName) {
  if (widget is SimpleDialogItem) {
    return widget.icon == icon && widget.itemName == itemName;
  }
  return false;
}

bool textFieldMatcher(Widget widget, String labelText, String hintText) {
  if (widget is Editor) {
    return widget.labelText == labelText && widget.hintText == hintText;
  }
  return false;
}

bool textFieldByLabelMatcher(Widget widget, String labelText) {
  if (widget is TextField) {
    return widget.decoration.labelText == labelText;
  }
  return false;
}
