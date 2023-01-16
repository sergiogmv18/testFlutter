import 'package:flutter/material.dart';
import 'package:test/component/component_circular_progress_indicator.dart';
import 'package:test/controllers/storage_controller.dart';
import 'package:test/controllers/user_controller.dart';
import 'package:test/helpers/FunctionsClass.dart';
import 'package:test/style.dart';

import '../../controllers/contact_controller.dart';

class ContactsScreen extends StatefulWidget {

  @override
  ContactsScreenState createState() => ContactsScreenState();
}
class ContactsScreenState extends State<ContactsScreen> with TickerProviderStateMixin<ContactsScreen> {
  List contactList = [];
  bool showProccessLoad = true;
  String? search;
   final StorageController storageController = StorageController();
  final UserController userController = UserController();
  ContactController contactController = ContactController();
  Map<String,dynamic> storage = {};
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
      storage = await storageController.readAppStorage();
      FunctionsClass.printDebug(storage);
      contactList = storage['contacts'];
    }
     setState(() {
      showProccessLoad = false;
    });      

  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async => false, 
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.refresh,
          color: Theme.of(context).primaryColor,
        ),
        onPressed: () async{
          showCircularLoadingDialog(context);
          if(contactList.isEmpty){
           // Map<String, dynamic>? response = await contactController.getContactsFromBroke();
            //await contactController.saveContactLocal(response);
          }else{
          //  await contactController.updateContactsFromBroke();
          }
          initialSetup();
          Navigator.of(context).pop();
         
        }),
        body: verifyAndShowWidget(contactList)
      ),
    );
  }



/*
  * verify if exist contact 
  * @author  SGV
  * @version 1.0 - 20220420 - initial release
  * param <String> contactList - contact list 
  * @return<widget>
  */
  verifyAndShowWidget(var contactList){
    if(contactList.isNotEmpty){
      return Column(
        children: [
          SizedBox(height: 20,),
          Container(
            color: Colors.transparent,
            width:  MediaQuery.of(context).size.width - 40,
            padding: EdgeInsets.fromLTRB(10, 0, 10, 1),
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 20), // add padding to adjust text
                isDense: true,
                hintText: ("search"),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(top: 15), // add padding to adjust icon
                  child: Icon(Icons.search,
                    size:28 ,
                  ),
                ),
              ),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.name,
              initialValue: null,
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
            ),
          ),
          SizedBox(height: 20),
          showContactList(search),
        ],
      );
    }else{
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
           
            Text(('no contact'),
              textAlign: TextAlign.center,
            ),
          ]
        ) 
      );
    }
  }

 /*
  * Show list of contact 
  * @author  SGV
  * @version 1.0 - 20220419 - initial release
  * @version 1.2 - 20220429 - Do a search without an accent and placing everything in to lower case
  * param <String> search - filter search 
  * @return<widget>
  */
  showContactList(String? search){
    List contactFilter = [];
    if(search == null || search.isEmpty){
      contactFilter = contactList..sort((a, b) => a.getContats()['fullName'].toLowerCase()!.compareTo(b.getContats()['fullName'].toLowerCase()));
    }else{
    //  search = FunctionsClass.removeAccents(search).toLowerCase();
      for(var contact in contactList){
     //   if(FunctionsClass.removeAccents(contact.getContats()['fullName']).toLowerCase().contains(search)) { 
          contactFilter.add(contact);
       // }
      }
    }
    return Expanded(
      child:ListView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        children: [
          for(var contact in contactFilter)...[
            GestureDetector(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center ,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                    height: MediaQuery.of(context).size.height / 13,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor:CustomColors().errorColor,
                      child: Text(contact.getContats()['fullName'][0]),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    width:  MediaQuery.of(context).size.width * 0.75,
                    child:contact.getContats()['fullName'] != null && contact.getContats()['fullName'] != '!UNKNOWN!' ?  Text(contact.getContats()['fullName'].toString(),
                    ): Text('')
                  ),
                ],
              ),
              onTap: (){
                Navigator.of(context).pushNamedAndRemoveUntil('/contact/info', (route) => false, arguments: contact);
              },
            ),
            SizedBox(height: 10),
          ],  
        ] 
      ) 
    );
  }
}