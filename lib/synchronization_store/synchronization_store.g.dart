// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'synchronization_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SynchronizationStore on _SynchronizationStore, Store {
  final _$synchronizingAtom = Atom(name: '_SynchronizationStore.synchronizing');

  @override
  bool get synchronizing {
    _$synchronizingAtom.reportRead();
    return super.synchronizing;
  }

  @override
  set synchronizing(bool value) {
    _$synchronizingAtom.reportWrite(value, super.synchronizing, () {
      super.synchronizing = value;
    });
  }

  final _$_SynchronizationStoreActionController =
      ActionController(name: '_SynchronizationStore');

  @override
  dynamic setSynchronizing(bool value) {
    final _$actionInfo = _$_SynchronizationStoreActionController.startAction(
        name: '_SynchronizationStore.setSynchronizing');
    try {
      return super.setSynchronizing(value);
    } finally {
      _$_SynchronizationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
synchronizing: ${synchronizing}
    ''';
  }
}
