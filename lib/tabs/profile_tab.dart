import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gas_calculator/components/custom_submit_buttom.dart';
import 'package:gas_calculator/stores/home_store/home_store.dart';
import 'package:gas_calculator/stores/login_store/login_store.dart';
import 'package:get_it/get_it.dart';

class ProfileTab extends StatelessWidget {
  final HomeStore homeStore = GetIt.I<HomeStore>();
  final LoginStore loginStore = GetIt.I<LoginStore>();

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32), child: Column(
      children: [

        Text(loginStore.currentUser.displayName??loginStore.currentUser.email),

        SubmitButton(
          text: "Sign out",
          onPressed: () {
            homeStore.setTab(homeStore.homePageIndex);
            loginStore.signOut(context);
          },
        )
      ],
    ),) ;
  }
}
