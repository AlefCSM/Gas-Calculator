// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStore, Store {
  final _$tabAtom = Atom(name: '_HomeStore.tab');

  @override
  int get tab {
    _$tabAtom.reportRead();
    return super.tab;
  }

  @override
  set tab(int value) {
    _$tabAtom.reportWrite(value, super.tab, () {
      super.tab = value;
    });
  }

  final _$_HomeStoreActionController = ActionController(name: '_HomeStore');

  @override
  dynamic setTab(int value) {
    final _$actionInfo =
        _$_HomeStoreActionController.startAction(name: '_HomeStore.setTab');
    try {
      return super.setTab(value);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tab: ${tab}
    ''';
  }
}
