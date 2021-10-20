// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connectivity_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConnectivityStore on _ConnectivityStore, Store {
  final _$isConnectedAtom = Atom(name: '_ConnectivityStore.isConnected');

  @override
  bool get isConnected {
    _$isConnectedAtom.reportRead();
    return super.isConnected;
  }

  @override
  set isConnected(bool value) {
    _$isConnectedAtom.reportWrite(value, super.isConnected, () {
      super.isConnected = value;
    });
  }

  final _$_ConnectivityStoreActionController =
      ActionController(name: '_ConnectivityStore');

  @override
  void setConnection(bool value) {
    final _$actionInfo = _$_ConnectivityStoreActionController.startAction(
        name: '_ConnectivityStore.setConnection');
    try {
      return super.setConnection(value);
    } finally {
      _$_ConnectivityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isConnected: ${isConnected}
    ''';
  }
}
