import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gas_calculator/components/confirmation_dialog.dart';
import 'package:gas_calculator/components/warning_dialog.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  @observable
  int tabIndex = 0;

  @action
  setTab(int value) {
    if (tabIndex != value) {
      tabIndex = value;
    }
  }

  get homePageIndex => 0;

  get chartPageIndex => 1;

  void navigateToPage(
      {required BuildContext context,
      required Widget page,
      required Function callback}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    ).then((value) => callback());
  }

  Future showDisconnectionDialog({required BuildContext context}) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => WarningDialog(
            title: "Warning",
            description: "You are currently offline !",
            textButton: "Ok",
          ));


  Future<bool?> showConfirmationDialog(
      {required BuildContext context,
        required String title,
        required String description,
        required String confirmButton,
        required String cancelButton,
        Function? confirmFunction,
        Function? cancelFunction}) =>
      showDialog(
          context: context,
          builder: (BuildContext context) => ConfirmationDialog(
              title: title,
              description: description,
              confirmButton: confirmButton,
              confirmFunction: confirmFunction,
              cancelButton: cancelButton,
              cancelFunction: cancelFunction));
}