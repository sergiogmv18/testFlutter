
import 'package:flutter/material.dart';

/*
 * Component of button defauld, to be used throughout the app
 * @author  SGV - 20230111 
 * @version 1.0 - 20230111 - initial release
 * @param   <onPressed> Function to define action of button  
 * @param   <customCollor> define color 
 * @param   <child> It has to be defined in some child, in order for it to work 
 *                   perfectly example: Container(child:careConnectButton())
 * @return  <component> ElevatedButton
 */


ElevatedButton buttonCustom(BuildContext context, { required void Function() onPressed, required Widget child, Color? customCollor}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(backgroundColor: customCollor, textStyle: TextStyle(fontSize: 20),  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0))),
    ),
    onPressed: onPressed,
    child: Container(
      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: child,
    ),
  );
}
