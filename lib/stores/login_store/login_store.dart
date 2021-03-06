import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:gas_calculator/pages/login_page.dart';
import 'package:gas_calculator/persistence/gas_calculatore_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

enum LoginForms { LOGIN, REGISTER, LOST_PASSWORD }

abstract class _LoginStore with Store {
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  @observable
  User? currentUser;

  @observable
  bool loading = false;

  @observable
  LoginForms currentForm = LoginForms.LOGIN;

  String profileName = "";
  String email = "";
  String password = "";
  String confirmPassword = "";

  @action
  setCurrentUser(User? value) => currentUser = value;

  @action
  setCurrentForm(LoginForms form) => currentForm = form;

  @action
  setPassword(String value) => password = value;

  @action
  setConfirmPassword(String value) => confirmPassword = value;

  @action
  setLoading(bool value) => loading = value;

  @computed
  get hasUser => currentUser != null;

  void getUser() {
    setLoading(true);
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user != null) {
        await Future.delayed(Duration(seconds: 5));
      }
      setCurrentUser(user);
      setLoading(false);
    });
  }

  register(BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null)
        user.updateDisplayName(profileName).then((value) {
          setCurrentUser(user);
        });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  signInWithEmail(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;
      if (user != null) setCurrentUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final authCredential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(authCredential);

        final user = userCredential.user;
        if (user != null) setCurrentUser(user);
      }
    } catch (error) {
      print(error);
    }
  }

  resetEmail() async {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    setCurrentForm(LoginForms.LOGIN);
  }

  Future signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    await deleteUserData();
    setCurrentForm(LoginForms.LOGIN);
  }

  pushToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  Future deleteUserData() async {
    await GasCalculatorDatabase.instance.deleteUserData();
  }
}
