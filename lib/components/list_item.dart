import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gas_calculator/assets/custom_colors/color_constants.dart';

class ListItem extends StatelessWidget {
  late final String text;

  ListItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(text,style: TextStyle(color: kDoveGrey,fontWeight: FontWeight.w500),),Icon(CupertinoIcons.right_chevron,color: kDoveGrey,)],
            ),
            Container(margin: EdgeInsets.only(top: 10),child:Divider() ,)
            ,
          ],
        ));
  }
}
