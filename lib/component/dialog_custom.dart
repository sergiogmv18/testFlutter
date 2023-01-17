import 'package:flutter/material.dart';
import 'package:test/style.dart';

/*
 * Dialog Custom standard to app 
 * @author  SGV       - 20230113
 * @version 1.0       - 20230113    - initial release
 * @version 1.1       - 20230114    - add new param titleWidget
 * @param   <String>  - title       - title of dialog 
 * @param   <List<Widget>>  - actions   - Bottom 
 * @param   <List<Widget>>  - children   - list of widget 
 * @return  <component> DialogCustom
 */
class DialogCustom extends StatelessWidget {
  final String? title;  
  List<Widget>? actions;
  List<Widget>? children;
  DialogCustom({Key? key, this.title, this.actions, this.children}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: AlertDialog(
        title:  Text(
         title!,
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: children ?? [],
          ),
        ),
        actions: actions,
      ),
    );
  }
}
