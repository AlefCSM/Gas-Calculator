import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {

  @observable
  int tab = 0;


  @action
  setTab(int value) {
    if (tab != value) {
      tab = value;
    }
  }



  get homePageIndex => 0;
  get chartPageIndex => 1;

}