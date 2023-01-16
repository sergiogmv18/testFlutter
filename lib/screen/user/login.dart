import 'dart:developer';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:search_cep/search_cep.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/component/button_component.dart';
import 'package:test/component/component_circular_progress_indicator.dart';
import 'package:test/component/pin_code_custom.dart';
import 'package:test/controllers/storage_controller.dart';
import 'package:test/controllers/user_controller.dart';
import 'package:test/helpers/FunctionsClass.dart';
import 'package:test/style.dart';

import '../../component/will_pop_scope_custom.dart';

class LoginScreen extends StatefulWidget {
  final Map<String, dynamic>? data;
  const LoginScreen({Key? key, this.data}) : super(key: key);
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  String? name;
  String? password;
  bool checkMandatoryData = false;
  

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
    final viaCepSearchCep = ViaCepSearchCep();
    final infoCepJSON = await viaCepSearchCep.searchInfoByCep(cep: '81630100');
    final infoCepXML = await viaCepSearchCep.searchInfoByCep(cep: '81630100', returnType: SearchInfoType.xml);
    log(infoCepXML.toString());
    print(infoCepJSON.fold((_) => null, (data) => data));
    if (widget.data != null) {
      if (widget.data != null) {}
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return willPopScopeCustom(
        context: context,
        child: Scaffold(
          backgroundColor: CustomColors().aiAqua,
          body: Center(
            child: Container(
              alignment:Alignment.center, 
              width: MediaQuery.of(context).size.width * 0.4,
              padding: const EdgeInsets.fromLTRB(20, 10.0, 20.0, 20.0),
              child: Card(
                child:   
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Bemvido ao Test",
                      style: Theme.of(context).textTheme.subtitle1,
                      textAlign: TextAlign.center,
                       ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            TextField(
                               keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
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

                            const SizedBox(height: 20,),
                             TextField(
                              keyboardType: TextInputType.visiblePassword,
                              decoration:const InputDecoration(
                                labelText: "Senha",
                              ),
                              onChanged:(value){
                                setState(() {
                                  if(value.isNotEmpty){
                                    password = value;
                                  }else{
                                    password = null;
                                  }
                                });

                              }
                            ),
                            if(checkMandatoryData)...[
                              const SizedBox(height: 20,),
                              Text("senha ou nome invalido",
                                style: Theme.of(context).textTheme.subtitle1!.copyWith(color:CustomColors().errorColor),
                                textAlign: TextAlign.center,
                              ),
                            ],
                            
                            const SizedBox(height: 20,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child:  buttonCustom(
                                context, 
                                customCollor: CustomColors().backgroundColor,
                                onPressed: ()async{
                                  showCircularLoadingDialog(context);
                                  Map<String, dynamic> data = {'password':password, 'name':name};
                                  Map<String, dynamic> response = await UserController().saveUser(data);
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
                                child: Text("Cadastrar",
                                  style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.white),
                                  textAlign: TextAlign.center,
                                )
                              )
                            )
                          ],
                        ),
                  ],
                ),
                    ) 
          )
          )
          )
       
            
            /*
            
             Center(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                shrinkWrap: true,
                children: [
                  
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                            TextSpan(
                              text: 'Bem vindo ao teste',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ])),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  

                  const SizedBox(height: 20),
                  Text('senha', style:Theme.of(context).textTheme.subtitle1,),
                  Container(
                    //padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    alignment: Alignment.center,
                    child: PinCodeCustom(
                      onChanged: (v) {},
                      onCompleted: (v) {
                        setState(() {
                          pinCode = v;
                          //showInputCode = true;
                        });
                      },
                    ),
                  ), //Container(height: 100),
                ],
              ),
            )*/
            ));
  }
}
