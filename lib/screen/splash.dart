import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/component/component_circular_progress_indicator.dart';
import 'package:test/component/will_pop_scope_custom.dart';
import 'package:test/controllers/storage_controller.dart';
import 'package:test/style.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool firstRun = true;
  @override
  void initState() {
    initialSetup();
    super.initState();
  }

  /*
  * Initial setup
  * @author  SGV
  * @version 1.0 - 20220111 - initial release
  * @return  void
  */
  Future<void> initialSetup() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('first_run') == true) {
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    } else {
      await StorageController().getAppStorage();
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    }
    setState(() {
      firstRun = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return willPopScopeCustom(
      context: context,
      child: Scaffold(
        backgroundColor: CustomColors().aiAqua,
        body: Center(child:testCircularProgressIndicator(context)),
      ));
  }
}
