import 'package:flutter/material.dart';
import 'package:test/component/dialog_custom.dart';
import 'package:test/screen/user/logout.dart';
import 'package:test/style.dart';

appBarCustom(BuildContext context) {
  return AppBar(
    title: Text(
      "Dashoard",
      style: Theme.of(context).textTheme.headline4!.copyWith(color: CustomColors().frontColor),
      textAlign: TextAlign.center,
    ),
    actions: [
      Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: GestureDetector(
          child: const Icon(Icons.logout),
          onTap: () async {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return LogoutScreen();
              },
            );
          },
        ),
      )
    ],
    centerTitle: true,
    backgroundColor: CustomColors().backgroundColor,
  );
}
