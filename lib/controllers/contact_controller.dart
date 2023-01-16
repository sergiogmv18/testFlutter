import 'package:test/controllers/storage_controller.dart';
import 'package:test/helpers/FunctionsClass.dart';

class ContactController {
  StorageController storageController =StorageController();
  /*
   * create contact
   * @author  SGV
   * @param <Map<String,dynamic>> data - data of Contact 
   * @version 1.0 - 20230112 - initial release
   */
  Future<Map<String, dynamic>> saveContact(Map<String, dynamic> data) async {
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
   * can the data be saved
   * @author  SGV
   * @param <Map<String,dynamic>> data - data contact 
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


}