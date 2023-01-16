

import 'package:flutter/material.dart';
import 'package:test/style.dart';

appBarCustom(BuildContext context){
  return AppBar(
    title:  Text("Dashoard",
          style: Theme.of(context).textTheme.headline4!.copyWith(color:CustomColors().frontColor),
          textAlign: TextAlign.center,
        ),
        actions: [
          Container(
            padding : EdgeInsets.fromLTRB(20, 0, 20, 0),
            child:   Icon(Icons.logout),
          )
        ],
        centerTitle: true,
        backgroundColor: CustomColors().backgroundColor,
  );
}