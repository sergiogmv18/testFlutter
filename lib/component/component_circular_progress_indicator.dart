import 'package:flutter/material.dart';

Widget testCircularProgressIndicator(BuildContext context) {
  return const Center(
    child: CircularProgressIndicator( color:  Colors.white,),
  );
}

/*
 * Show icon circular for expect loading next step 
 * @author  SGV - 20230112
 * @version 1.0 - 20230112 - initial release
 * @return  <component> showDialog and redirect to previous page
 */
Future<void> showCircularLoadingDialog(BuildContext context) async {  
  await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () => Future.value(false),
            child: testCircularProgressIndicator(context)
        );
      });
}
