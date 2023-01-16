import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:search_cep/search_cep.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/component/app_bar_component.dart';
import 'package:test/component/button_component.dart';
import 'package:test/component/component_circular_progress_indicator.dart';
import 'package:test/controllers/contact_controller.dart';
import 'package:test/controllers/storage_controller.dart';
import 'package:test/controllers/user_controller.dart';
import 'package:test/helpers/FunctionsClass.dart';
import 'package:test/style.dart';
import '../../component/will_pop_scope_custom.dart';

class InsertContactScreen extends StatefulWidget {
  final Map<String, dynamic>? data;
  const InsertContactScreen({Key? key, this.data}) : super(key: key);
  @override
  InsertContactScreenState createState() => InsertContactScreenState();
}

class InsertContactScreenState extends State<InsertContactScreen> {
  final StorageController storageController = StorageController();
  final UserController userController = UserController();
  Map<String,dynamic> storage = {};
  bool checkMandatoryData = false;
  String? name;
  
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
    if(!await userController.verifyInternalUrl()){
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false); 
    }else{
      
    }

    setState(() {
    });
  } 
  @override
  Widget build(BuildContext context) {
    return willPopScopeCustom(
      context: context,
      child: Scaffold(
        backgroundColor: CustomColors().aiAqua,
       appBar: appBarCustom(context),
        body: Column(
               crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
               Row(
                children: [
                  TextField(
                    keyboardType: TextInputType.name,
                    decoration:const InputDecoration(
                      labelText: "Nome",
                    ),
                    onChanged:(value){
                      setState(() {
                        if(value.isNotEmpty){
                          name = value;
                        }else{
                          name = null;
                        }
                      });
                    }
                  ),
                ],
              ),
                const SizedBox(height: 20,),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child:  buttonCustom(
                    context, 
                    customCollor: CustomColors().action,
                    onPressed: ()async{
                      showCircularLoadingDialog(context);
                      Map<String, dynamic> data = {'password':1, 'name':1};
                      Map<String, dynamic> response = await ContactController().saveContact(data);
                      FunctionsClass.printDebug('response : $response');
                      if (response['checkMandatoryData'] != null && response['checkMandatoryData']) {
                        Navigator.of(context).pop();
                        setState(() {
                          checkMandatoryData = true;
                        });
                        return;
                      }
                      FunctionsClass.printDebug(response);
                      if(response['success']){
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setBool('first_run', true);                                    
                        Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
                      }
                    }, 
                    child: Text("Salvar",
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    )
                  )
                )
              ],
            )
          
        
      )
    );
  }

}
