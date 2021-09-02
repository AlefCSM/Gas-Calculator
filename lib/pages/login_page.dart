import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gas_calculator/assets/custom_colors/color_constants.dart';
import 'package:gas_calculator/assets/custom_font_size/custom_font_size_constants.dart';
import 'package:gas_calculator/components/custom_submit_buttom.dart';
import 'package:gas_calculator/components/custom_text_form_field.dart';
import 'package:gas_calculator/stores/login_store/login_store.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const GOOGLE_LOGO = 'lib/assets/images/google_logo.svg';
  LoginStore loginStore = GetIt.I<LoginStore>();
  final _loginFormKey = GlobalKey<FormState>();
  final _registerFormKey = GlobalKey<FormState>();
  final _lostPasswordFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kAccentColor,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            color: kAccentColor,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Observer(
                builder: (_) {
                  switch (loginStore.currentForm) {
                    case LoginForms.REGISTER:
                      return registerCard();
                    case LoginForms.LOST_PASSWORD:
                      return forgotPasswordCard();
                    default:
                      return loginCard();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: kLighterGrey,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: kDarkGrey,
            blurRadius: 12,
            spreadRadius: -5.2,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                "Login",
                style: TextStyle(
                    fontSize: CustomFontSize.largest,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: CustomTextFormField(
                hint: "E-mail",
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onSaved: (value) => loginStore.email = value,
                validator: (value) {
                  if (value.isEmpty || value == null) {
                    return "Fill this field";
                  }
                  if (!EmailValidator.validate(value)) {
                    return "Incorrect e-mail";
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: CustomTextFormField(
                hint: "Password",
                isPassword: true,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty || value == null) {
                    return "Fill this field";
                  }
                },
                onSaved: (value) => loginStore.password = value,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: SubmitButton(
                text: "Login",
                onPressed: () {
                  if (_loginFormKey.currentState.validate()) {
                    _loginFormKey.currentState.save();
                    loginStore.signInWithEmail(context);
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: SubmitButton(
                prefixIcon: GOOGLE_LOGO,
                text: "Continue with Google",
                onPressed: () {
                  loginStore.signInWithGoogle(context);
                },
              ),
            ),
            Divider(),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Text("Forgot password?"),
                    onTap: () {
                      loginStore.setCurrentForm(LoginForms.LOST_PASSWORD);
                    },
                  ),
                  GestureDetector(
                    child: Text("Register"),
                    onTap: () {
                      loginStore.setCurrentForm(LoginForms.REGISTER);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget forgotPasswordCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: kLighterGrey,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: kDarkGrey,
            blurRadius: 12,
            spreadRadius: -5.2,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Form(
        key: _lostPasswordFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                "Forgot password",
                style: TextStyle(
                    fontSize: CustomFontSize.largest,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: CustomTextFormField(
                hint: "E-mail",
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onSaved: (value) => loginStore.email = value,
                validator: (value) {
                  if (value.isEmpty || value == null) {
                    return "Fill this field";
                  }
                  if (!EmailValidator.validate(value)) {
                    return "Incorrect e-mail";
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: SubmitButton(
                text: "Send e-mail",
                onPressed: () {
                  if (_lostPasswordFormKey.currentState.validate()) {
                    _lostPasswordFormKey.currentState.save();
                    loginStore.resetEmail();
                  }
                },
              ),
            ),
            Divider(),
            Container(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                child: Text("Go back"),
                onTap: () {
                  loginStore.setCurrentForm(LoginForms.LOGIN);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget registerCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: kLighterGrey,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: kDarkGrey,
            blurRadius: 12,
            spreadRadius: -5.2,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Form(
        key: _registerFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                "Register",
                style: TextStyle(
                    fontSize: CustomFontSize.largest,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: CustomTextFormField(
                hint: "Profile name",
                textInputAction: TextInputAction.next,
                onSaved: (value) => loginStore.profileName = value,
                validator: (value) {
                  if (value.isEmpty || value == null) {
                    return "Fill this field";
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: CustomTextFormField(
                hint: "E-mail",
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onSaved: (value) => loginStore.email = value,
                validator: (value) {
                  if (value.isEmpty || value == null) {
                    return "Fill this field";
                  }
                  if (!EmailValidator.validate(value)) {
                    return "Incorrect e-mail";
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: CustomTextFormField(
                hint: "Password",
                isPassword: true,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                onChanged: (value) => loginStore.setPassword(value),
                validator: (value) {
                  if (value.isEmpty || value == null) {
                    return "Fill this field";
                  }
                },
                // onSaved: (value) => loginPageStore.password = value,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: CustomTextFormField(
                hint: "Confirm password",
                isPassword: true,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                onChanged: (value) => loginStore.setConfirmPassword(value),
                validator: (value) {
                  if (value.isEmpty || value == null) {
                    return "Fill this field";
                  }
                  if (value != loginStore.password) {
                    return "Type the same password";
                  }
                },
                // onSaved: (value) => loginPageStore.password = value,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: SubmitButton(
                text: "Register",
                onPressed: () {
                  if (_registerFormKey.currentState.validate()) {
                    _registerFormKey.currentState.save();
                    loginStore.register(context);
                  }
                },
              ),
            ),
            Divider(),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 10),
              child: GestureDetector(
                child: Text("Go back"),
                onTap: () {
                  loginStore.setCurrentForm(LoginForms.LOGIN);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
