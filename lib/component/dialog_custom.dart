import 'package:flutter/material.dart';

/*
 * Dialog Custom standard to app 
 * @author  SGV       - 20230113
 * @version 1.0       - 20230113    - initial release
 * @version 1.1       - 20230114    - add new param titleWidget
 * @param   <String>  - title       - title of dialog 
 * @param   <Widget>  - container   - body of dialog  
 * @param   <Widget>  - button      - navigator button to dialog 
 * @param   <Widget>  - titleWidget - widget to tittle 
 * @return  <component> DialogCustom
 */
class DialogCustom extends StatelessWidget {
  final String? title;
  final Widget? container;
  final Widget? button;
  final double? fontSize;
  final Widget? titleWidget;
  const DialogCustom({Key? key, this.title, this.container, this.button, this.fontSize, this.titleWidget}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Dialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(3))),
            insetPadding: const EdgeInsets.all(10),
            child: Container(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: titleWidget != null ?
                    titleWidget!:
                    Text(
                      title!,
                      style: fontSize != null ? Theme.of(context).textTheme.headline6!.copyWith(fontSize: fontSize) : Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 18,
                    ),
                  ),
                  container!,
                  button!
                ]))));
  }
}
