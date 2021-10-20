import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gas_calculator/assets/custom_colors/color_constants.dart';
import 'package:gas_calculator/assets/custom_font_size/custom_font_size_constants.dart';
import 'package:gas_calculator/components/custom_submit_buttom.dart';
import 'package:gas_calculator/util/screen_util/screen_util.dart';

// ignore: must_be_immutable
class ConfirmationDialog extends StatefulWidget {
  final String title;
  final String description;
  final String subDescription;
  final String cancelButton;
  Function? cancelFunction;
  final String confirmButton;
  Function? confirmFunction;

  ConfirmationDialog({
    required this.title,
    required this.description,
    this.subDescription = "",
    required this.confirmButton,
    required this.cancelButton,
    this.cancelFunction,
    this.confirmFunction,
  });

  @override
  _ConfirmationDialogState createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog>
    with ScreenUtil {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: mediaQueryTextFactor(context, ScreenUtil.TEXT_FACTOR_1_0),
      child: AlertDialog(
        titlePadding:
            widget.description.isNotEmpty && widget.subDescription.isNotEmpty
                ? EdgeInsets.only(top: 20)
                : EdgeInsets.only(top: 10),
        contentPadding:
            widget.description.isNotEmpty && widget.subDescription.isNotEmpty
                ? const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0)
                : const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        title: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Text(
                widget.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: CustomFontSize.large,
                  color: kDarkGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 16.0),
        content:
            widget.description.isNotEmpty || widget.subDescription.isNotEmpty
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        Visibility(
                          visible: widget.description.isNotEmpty,
                          child: Container(
                            child: Text(
                              widget.description,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: CustomFontSize.regular,
                                color: kGrey,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          replacement: Container(),
                        ),
                        Visibility(
                          visible: widget.subDescription.isNotEmpty,
                          child: Container(
                            margin: EdgeInsets.only(top: 16),
                            child: Text(
                              widget.subDescription,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: CustomFontSize.small,
                                color: kGrey,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          replacement: Container(),
                        ),
                      ],
                    ),
                  )
                : SizedBox.shrink(),
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 45.0,
                  width: 120.0,
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: OutlinedButton(
                    child: Text(
                      widget.cancelButton,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: CustomFontSize.regular,
                        color: kDarkBlueColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () {
                      if (widget.cancelFunction != null) {
                        widget.cancelFunction!();
                      } else {
                        Navigator.pop(context, false);
                      }
                    },
                  ),
                ),
                Container(
                  height: 45.0,
                  width: 120.0,
                  margin: EdgeInsets.only(left: 10.0, bottom: 10),
                  child: SubmitButton(
                    loading: loading,
                    text: widget.confirmButton,
                    onPressed: () async {
                      if (widget.confirmFunction != null) {
                        setState(() {
                          loading = true;
                        });
                        await widget.confirmFunction!();
                        setState(() {
                          loading = false;
                        });
                      } else {
                        Navigator.pop(context, true);
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
