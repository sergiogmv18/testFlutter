import 'dart:developer';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:search_cep/search_cep.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/component/button_component.dart';
import 'package:test/component/component_circular_progress_indicator.dart';
import 'package:test/controllers/storage_controller.dart';
import 'package:test/controllers/user_controller.dart';
import 'package:test/helpers/FunctionsClass.dart';
import 'package:test/style.dart';

import '../../component/will_pop_scope_custom.dart';

class LogoutScreen extends StatefulWidget {
  final Map<String, dynamic>? data;
  const LogoutScreen({Key? key, this.data}) : super(key: key);
  @override
  LogoutScreenState createState() => LogoutScreenState();
}

class LogoutScreenState extends State<LogoutScreen> {
  String? name;
  String? password;
  bool checkMandatoryData = false;
  final StorageController storageController = StorageController();
  Map<String, dynamic> storage = {};
  String? passwordCurrent;

  @override
  void initState() {
    initialSetup();
    super.initState();
  }

  /*
    * Initial setup
    * @author  SGV
    * @version 1.0 - 20220706 - initial release
    * @return  void
    */
  Future<void> initialSetup() async {
    storage = await storageController.readAppStorage();
    FunctionsClass.printDebug(storage);
    passwordCurrent = storage['user']['password'];
    setState(() {});
  }

  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Logout',
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              "Para deslogar precisa colocar sua senha em baixo",
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
            TextField(
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: "Senha",
                ),
                onChanged: (value) {
                  setState(() {
                    if (value.isNotEmpty) {
                      password = value;
                    } else {
                      password = null;
                    }
                  });
                }),
            if (checkMandatoryData) ...[
              const SizedBox(height: 20),
              Text(
                "senha invalida",
                style: Theme.of(context).textTheme.subtitle1!.copyWith(color: CustomColors().errorColor),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 20),
            buttonCustom(context, 
              onPressed: () async {
                if (password != passwordCurrent) {
                  setState(() {
                    checkMandatoryData = true;
                  });
                } else {
                  await UserController().logout();
                  Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                }
              },
              customCollor: CustomColors().action,
              child: Text(
                  "Logout",
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ))
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.red,
          ),
          child: const Text('cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
