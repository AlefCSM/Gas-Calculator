import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gas_calculator/assets/custom_colors/color_constants.dart';
import 'package:gas_calculator/assets/custom_font_size/custom_font_size_constants.dart';
import 'package:gas_calculator/components/custom_error_text.dart';
import 'package:gas_calculator/util/screen_util/screen_util.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final bool isPassword;
  final Function validator;
  final Function onSaved;
  final Function(String) onChanged;
  final Function onChangeFocus;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool onlyLowerCase;
  final bool onlyUpperCase;
  final String initialValue;
  final Key fieldKey;
  final FocusNode focusNode;
  final List<TextInputFormatter> inputFormatters;
  final Widget suffix;
  final bool isEnabled;
  final Color disabledColor;
  final Color backgroundColor;
  final BoxConstraints suffixIconConstraints;
  final bool uppercase;
  final int maxLength;

  CustomTextFormField({
    Key key,
    @required this.hint,
    this.isPassword = false,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.onSaved,
    this.onChanged,
    this.initialValue,
    this.inputFormatters,
    this.controller,
    this.onlyLowerCase,
    this.onlyUpperCase,
    this.onChangeFocus,
    this.fieldKey,
    this.focusNode,
    this.suffix,
    this.suffixIconConstraints,
    this.isEnabled = true,
    this.disabledColor = kLighterGrey,
    this.backgroundColor = kWhiteColor,
    this.uppercase = false,
    this.maxLength,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> with ScreenUtil {
  bool showText = false;
  bool _isValid = true;
  String _messageError = "";
  bool onlyLowerCase;
  bool onlyUpperCase;
  Key key;
  List<TextInputFormatter> inputFormatters;

  static const _EMPTY_STRING_REPRESENTING_ERROR = "";

  @override
  void initState() {
    super.initState();

    onlyUpperCase = widget.onlyUpperCase;
    onlyUpperCase ??= false;
    onlyLowerCase = widget.onlyLowerCase;
    onlyLowerCase ??= false;

    key = widget.fieldKey;
    key ??= UniqueKey();
  }

  @override
  Widget build(BuildContext context) {
    _setFormatters();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: Container(
            height: 50.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: widget.isEnabled
                  ? widget.backgroundColor
                  : widget.disabledColor,
              border: _isValid
                  ? Border.all(
                      color: kLighterGreyColor,
                      width: 1.0,
                    )
                  : Border.all(
                      color: kRedColor,
                      width: 1.0,
                    ),
              boxShadow: _isValid
                  ? []
                  : [
                      BoxShadow(
                        color: kRedColor.withOpacity(.2),
                        spreadRadius: 1.0,
                        blurRadius: 1.0,
                        offset: Offset.zero, // changes position of shadow
                      )
                    ],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Focus(
              onFocusChange: widget.onChangeFocus,
              child: TextFormField(
                textCapitalization: widget.uppercase
                    ? TextCapitalization.characters
                    : TextCapitalization.none,
                enabled: widget.isEnabled,
                key: key,
                maxLength: widget.maxLength,
                controller: widget.controller,
                initialValue: widget.initialValue,
                inputFormatters: inputFormatters,
                onSaved: widget.onSaved,
                focusNode: widget.focusNode,
                onEditingComplete: widget.focusNode != null
                    ? widget.focusNode.nextFocus
                    : null,
                onChanged: widget.onChanged,
                keyboardType: widget.keyboardType,
                textInputAction: widget.textInputAction,
                obscureText: widget.isPassword && !showText,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (widget.validator != null) {
                    final prevMessage = _messageError;
                    final message = widget.validator(value);
                    bool valid = false;
                    if (message == null) {
                      valid = true;
                      _messageError = null;
                    } else {
                      valid = false;
                      _messageError = message;
                    }
                    _messageError = message;
                    if (valid != _isValid || prevMessage != message) {
                      Future.delayed(
                        Duration.zero,
                        () async {
                          setState(
                            () {
                              _isValid = valid;
                              _messageError = message;
                            },
                          );
                        },
                      );
                    }
                    if (!valid) {
                      return _EMPTY_STRING_REPRESENTING_ERROR;
                    }
                  }
                  return null;
                },
                style: TextStyle(
                  backgroundColor: Colors.transparent,
                  fontSize: CustomFontSize.small,
                  color: kGrey,
                ),
                decoration: InputDecoration(
                  counterStyle: TextStyle(
                    height: double.minPositive,
                  ),
                  counterText: "",
                  filled: false,
                  contentPadding: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 20,
                    right: 13,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  labelText: widget.hint,
                  errorStyle: TextStyle(
                    backgroundColor: Colors.transparent,
                    height: 0.0,
                  ),
                  labelStyle: TextStyle(
                    color: _isValid ? kGrey : kRedColor,
                    decorationColor: Colors.transparent,
                    decorationStyle: TextDecorationStyle.solid,
                    fontSize: CustomFontSize.regular,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  hintStyle: TextStyle(
                    fontSize: CustomFontSize.small,
                  ),
                  suffixIconConstraints: widget.suffixIconConstraints,
                  suffixIcon: widget.isPassword
                      ? IconButton(
                          icon: FittedBox(
                            child: Icon(
                              showText
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              size: 16.0,
                              color: Theme.of(context).hintColor,
                            ),
                            fit: BoxFit.fill,
                          ),
                          onPressed: () {
                            setState(
                              () {
                                showText = !showText;
                              },
                            );
                          },
                        )
                      : widget.suffix,
                ),
              ),
            ),
          ),
        ),
        _isValid || _messageError == null || _messageError == ""
            ? SizedBox.shrink()
            : CustomErrorText(
                text: _messageError,
                align: TextAlign.right,
              ),
      ],
    );
  }

  void _setFormatters() {
      inputFormatters = widget.inputFormatters;
      inputFormatters ??= [];

      if (onlyUpperCase) {
        inputFormatters
            .add(FilteringTextInputFormatter.allow(RegExp(r'[^a-z]')));
      } else if (onlyLowerCase) {
        inputFormatters
            .add(FilteringTextInputFormatter.allow(RegExp(r'[^A-Z]')));
      }
  }
}
