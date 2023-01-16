import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/controllers/storage_controller.dart';
import 'package:test/helpers/FunctionsClass.dart';

class UserController{
  StorageController storageController =StorageController();

  /*
   * create or edit user
   * @author  SGV
   * @param <Map<String,dynamic>> data - data of user 
   * @version 1.0 - 20230112 - initial release
   */
  Future<Map<String, dynamic>> saveUser(Map<String, dynamic> data) async {
   Map<String, dynamic> storage = await storageController.readAppStorage();
    FunctionsClass.printDebug(data);
    Map<String, dynamic> response = {};
    if (!canTheDataBeSaved(data)) {
      return {'success': false, 'checkMandatoryData': true};
    }
    storage['user'] = data;
    await storageController.writeAppStorage(storage);  
    response['success'] = true; 
   
    return response;
  }

  /*
   * can the user be saved
   * @author  SGV
   * @param <Map<String,dynamic>> data - data of user 
   * @version 1.0 - 20230112 - initial release
   * @return  bool
   */
  bool canTheDataBeSaved(Map<String, dynamic> data) {
    if (data['name'] == null) {
      return false;
    }
    if (data['password'] == null) {
      return false;
    }
    return true;
  }

  
  /*
   * Verify if login to user
   * @author  SGV
   * @version 1.0 - 20230112 - initial release
   * @return  bool
   */
  Future<bool>verifyInternalUrl()async{
    bool session = false;
    final prefs = await SharedPreferences.getInstance();  
   if (prefs.getBool('first_run') == true) {
      session = true;
    }
    return session;
  }

}