import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageController {
  /*
   * Create storage of app 
   * @author  SGV      - 20230112
   * @version 1.0      - 20230112  - Initial release 
   * @return  <void>
   */
  Future<void> getAppStorage([String name = 'storage']) async {
    final storage = await SharedPreferences.getInstance();
     Map<String, dynamic> data = {'user':'','contacts':[]};
    storage.setString(name, json.encode(data));
  }

  /*
   * Write the storage with the user data 
   * @author  SGV    - 20230112
   * @version 1.0    - 20230112  - Initial release 
   * @return  <void> 
   */
  Future<void> writeAppStorage(Map<String, dynamic>? value) async {
    final storage = await SharedPreferences.getInstance();
    String response = json.encode(value);
    storage.setString('storage', response);
  }

  /*
  * Read the storage with the user data 
  * @author  SGV    - 20230112
  * @version 1.0    - 20230112  - Initial release 
  * @return  <Map<String, dynamic>> 
  */
  Future<Map<String, dynamic>> readAppStorage() async {
    final storage = await SharedPreferences.getInstance();
    String? data = storage.getString('storage');
    Map<String, dynamic> response = data != null ? json.decode(data) : {};
    return response;
  }
}
