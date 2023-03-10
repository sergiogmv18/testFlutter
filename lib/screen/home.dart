import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:test/component/app_bar_component.dart';
import 'package:test/component/button_component.dart';
import 'package:test/component/will_pop_scope_custom.dart';
import 'package:test/controllers/contact_controller.dart';
import 'package:test/controllers/storage_controller.dart';
import 'package:test/controllers/user_controller.dart';
import 'package:test/helpers/FunctionsClass.dart';
import 'package:test/screen/contact/contact_screen.dart';
import 'package:test/screen/contact/google_map.dart';
import 'package:test/style.dart';

class HomeScreen extends StatefulWidget {
  final Map? data;

  const HomeScreen({Key? key, this.data}) : super(key: key);
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final StorageController storageController = StorageController();
  bool progress = true;
  final UserController userController = UserController();
  Map<String, dynamic> storage = {};
  bool contacts = false;
  late List markers = <Marker>[];
  @override
  void initState() {
    initialSetup();
    super.initState();
  }

  /*
  * Initial setup
  * @author  SGV
  * @version 1.0 - 20230111 - initial release
  * @return  void
  */
  Future<void> initialSetup() async {
    if (!await userController.verifyInternalUrl()) {
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    } else {
      storage = await storageController.readAppStorage();
      contacts = storage['contacts'].isNotEmpty ?? true;
      FunctionsClass.printDebug(storage['contacts']);
      if (contacts) {
        markers = await ContactController().allMarkersContancts(storage['contacts']);
      }
    }
    setState(() {
      progress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return willPopScopeCustom(
        context: context,
        child: Scaffold(
          backgroundColor: CustomColors().aiAqua,
          floatingActionButton: contacts
              ? FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil('/insert/contact', (route) => false);
                  },
                  backgroundColor: CustomColors().action,
                  child: Icon(
                    Icons.add,
                    color: CustomColors().frontColor,
                    size: 36,
                  ),
                )
              : null,
          appBar: appBarCustom(context),
          body: progress ? const Center(child: CircularProgressIndicator()): showSpecificWidget(contacts),
        ));
  }

  /*
  * Verify if contact list is empty and show widget
  * @author  SGV
  * @version 1.0 - 20230111 - initial release
  * @return  void
  */
  showSpecificWidget(bool showContact) {
    if (showContact) {
      return Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: ContactsScreen(),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: GoogleMapScreen(markers: markers),
          )
        ],
      );
    }
    return Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
      Text(
        "sem cotatos, por favor adicione um cotato",
        style: Theme.of(context).textTheme.headline4!.copyWith(color: CustomColors().frontColor),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 20),
      buttonCustom(context, customCollor: CustomColors().action, onPressed: () async {
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/insert/contact',
          (route) => false,
        );
      },
          child: Text(
            "Adicionar",
            style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ))
    ]));
  }
}
