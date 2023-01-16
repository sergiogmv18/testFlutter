import 'package:flutter/material.dart';

/*
 * will pop scope custom
 * @author  SGV - 20230111
 * @version 1.0 - 20230111 - initial release
 * @param  <BuildContext>  context  
 * @param  <Widget> child
 * @param  <String> routeName - route to be redirected when button return is clicked
 * @return WillPopScope
 */
WillPopScope willPopScopeCustom({Key? key, required BuildContext context, required Widget child, String? routeName}) {
    if (routeName != null) {
      return WillPopScope(
      key: key,
      child: child,
      onWillPop: () async {
        Navigator.of(context).pushNamedAndRemoveUntil(routeName, (route) => false);
        return true;
      });
    }else{
    return WillPopScope(
      key: key,
      child: child,
      onWillPop: () async {
        return false;
      }
    );
  }
}
