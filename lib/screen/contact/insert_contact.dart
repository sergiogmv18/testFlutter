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
  Map<String, dynamic> storage = {};
  bool checkMandatoryData = false;
  String? logradouro;
  String? uf;
  String? localidade;
  String? name;
  String? complemento;
  String? cep;
  String? bairro;
  String? sobreNome;
  String? endereco;
  bool validInput = false;
  final controllerLocalidade = TextEditingController();
  final controllerEndereco = TextEditingController();
  final controllerBairro = TextEditingController();
  final controllerLogradouro = TextEditingController();
  final controllerUf = TextEditingController();
  Map<String, dynamic> contact = {};

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
    if (!await userController.verifyInternalUrl()) {
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    } else {}

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return willPopScopeCustom(
        context: context,
        child: Scaffold(
            backgroundColor: CustomColors().aiAqua,
            appBar: appBarCustom(context),
            body: Container(
                padding: const EdgeInsets.fromLTRB(20, 10.0, 20.0, 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextField(
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                labelText: "Nome",
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: CustomColors().blackColor),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: CustomColors().frontColor),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  if (value.isNotEmpty) {
                                    name = value;
                                  } else {
                                    name = null;
                                  }
                                });
                              }),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextField(
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                labelText: "sobre nome",
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: CustomColors().blackColor),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: CustomColors().frontColor),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  if (value.isNotEmpty) {
                                    sobreNome = value;
                                  } else {
                                    sobreNome = null;
                                  }
                                });
                              }),
                        )
                      ],
                    ),
                   const SizedBox(height: 20),
// CEP
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: TextField(
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                labelText: "CEP",
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: CustomColors().blackColor),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: CustomColors().frontColor),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  if (value.isNotEmpty) {
                                    cep = value;
                                  } else {
                                    cep = null;
                                  }
                                });
                              }
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          buttonCustom(
                            context, 
                            customCollor: CustomColors().action, 
                            onPressed: () async {
                              ViaCepInfo? data;
                              showCircularLoadingDialog(context);
                              final viaCepSearchCep = ViaCepSearchCep();
                              final infoCepJSON = await viaCepSearchCep.searchInfoByCep(cep: cep!);
                              data = infoCepJSON.fold((_) => null, (data) => data);
                              setState(() {
                                localidade = data!.localidade;
                                uf = data.uf;
                                controllerBairro.text = data.bairro!;
                                controllerLocalidade.text = localidade!;
                                controllerEndereco.text = data.logradouro!;
                                controllerUf.text = data.uf!;
                                endereco = data.logradouro!;
                                validInput = true;
                              });
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "search",
                              style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                            )
                          )
                        ],
                      )
                    ),
                    if(checkMandatoryData)...[
                      const SizedBox(height: 20,),
                      Text("prencha todos os campos",
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(color:CustomColors().errorColor),
                        textAlign: TextAlign.center,
                      ),
                    ],
                    const SizedBox(
                      height: 20,
                    ),
                    if(validInput)...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(
                            children: [
                              TextField(
                                keyboardType: TextInputType.name,
                                controller: controllerBairro,
                                enabled: false,
                                decoration: InputDecoration(
                                  labelText: "Bairro",
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: CustomColors().blackColor),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: CustomColors().frontColor),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    if (value.isNotEmpty) {
                                      controllerBairro.text = value;
                                      bairro = value;
                                    } else {
                                      bairro = null;
                                    }
                                  });
                                }
                              ),
                              
                              ],
                            )
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.10),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: TextField(
                              controller: controllerLocalidade,
                              keyboardType: TextInputType.name,
                              enabled: false,
                              decoration: InputDecoration(
                                labelText: "Localidade",
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: CustomColors().blackColor),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: CustomColors().frontColor),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  if (value.isNotEmpty) {
                                    controllerLocalidade.text = value;
                                  }
                                });
                              }
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
// 1111111
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(
                            children: [
                              TextField(
                                keyboardType: TextInputType.name,
                                controller: controllerEndereco,
                                enabled: false,
                                decoration: InputDecoration(
                                  labelText: "endereço",
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: CustomColors().blackColor),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: CustomColors().frontColor),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    if (value.isNotEmpty) {
                                      controllerEndereco.text = value;
                                      endereco = value;
                                    } else {
                                      endereco = null;
                                    }
                                  });
                                }
                              ),
                              
                              ],
                            )
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.10),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: TextField(
                              controller: controllerUf,
                              keyboardType: TextInputType.name,
                              enabled: false,
                              decoration: InputDecoration(
                                labelText: "UF",
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: CustomColors().blackColor),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: CustomColors().frontColor),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  if (value.isNotEmpty) {
                                    controllerLocalidade.text = value;
                                  }
                                });
                              }
                            ),
                          ),
                      ],
                    ),
// 2222222222
                    const SizedBox(height: 40),
                    Column(
                        children: [
                          buttonCustom(context, customCollor: CustomColors().action, onPressed: () async {
                        //  showCircularLoadingDialog(context);
                         // Map<String, dynamic> data = {'password': 1, 'name': 1};
                         Map<String, dynamic> response ={}; //await ContactController().saveContact(data);
                         contact = {'name': '$name', 'sobreNome': '$sobreNome', 'endereco': {'endereco': endereco, 'bairro': controllerBairro.text, 'uf':controllerUf.text}};
                          FunctionsClass.printDebug('$contact');
                          await ContactController().saveContact(contact);
                          if (response['checkMandatoryData'] != null && response['checkMandatoryData']) {
                            Navigator.of(context).pop();
                            setState(() {
                              checkMandatoryData = true;
                            });
                            return;
                          }
                          FunctionsClass.printDebug(response);
                          if (response['success']) {
                            final prefs = await SharedPreferences.getInstance();
                            prefs.setBool('first_run', true);
                            Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
                          }
                        },
                            child: Text(
                              "Salvar",
                              style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                            ))

                        ],) 
                            
                            
                  ],
                  ],
                ))));
  }
}
