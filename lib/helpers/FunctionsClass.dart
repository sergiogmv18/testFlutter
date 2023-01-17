import 'dart:developer';

class FunctionsClass {

   /*
   *  print of variable 
   * @author  SGV
   * @version 1.0 - 20230111 - initial release
   * @param <dynamic> 
   * @return  String
   */
  static printDebug(var data) {
    log(data.toString());
  }

    /*
  * Delete accent in String
  * @author  SVM
  * @version 1.0 - 20220429 - initial release
  * @return  String
  */
  static String removeAccents(String str) {
    var withDia = 'ŠŒŽšœžŸ¥µÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøüùúûýýþÿŔŕƒ';
    var withoutDia = 'SOZsozYYuaaaaaaaceeeeiiiidnoooooouuuuybsaaaaaaaceeeeiiiidnoooooouuuuyybyRra';
    for (int i = 0; i < withDia.length; i++) {
      str = str.replaceAll(withDia[i], withoutDia[i]);
    }
    return str;
  }
}
