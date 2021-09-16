// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on _LoginStore, Store {
  Computed<dynamic>? _$hasUserComputed;

  @override
  dynamic get hasUser => (_$hasUserComputed ??=
          Computed<dynamic>(() => super.hasUser, name: '_LoginStore.hasUser'))
      .value;

  final _$currentUserAtom = Atom(name: '_LoginStore.currentUser');

  @override
  User? get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(User? value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  final _$loadingAtom = Atom(name: '_LoginStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$currentFormAtom = Atom(name: '_LoginStore.currentForm');

  @override
  LoginForms get currentForm {
    _$currentFormAtom.reportRead();
    return super.currentForm;
  }

  @override
  set currentForm(LoginForms value) {
    _$currentFormAtom.reportWrite(value, super.currentForm, () {
      super.currentForm = value;
    });
  }

  final _$_LoginStoreActionController = ActionController(name: '_LoginStore');

  @override
  dynamic setCurrentUser(User value) {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.setCurrentUser');
    try {
      return super.setCurrentUser(value);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCurrentForm(LoginForms form) {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.setCurrentForm');
    try {
      return super.setCurrentForm(form);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPassword(String value) {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setConfirmPassword(String value) {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.setConfirmPassword');
    try {
      return super.setConfirmPassword(value);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLoading(bool value) {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentUser: ${currentUser},
loading: ${loading},
currentForm: ${currentForm},
hasUser: ${hasUser}
    ''';
  }
}
