import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:test/controllers/storage_controller.dart';
import 'package:test/helpers/FunctionsClass.dart';
import 'package:geocode/geocode.dart';
import 'package:latlong2/latlong.dart';

class ContactController {
  StorageController storageController = StorageController();
  /*
   * create contact
   * @author  SGV
   * @param <Map<String,dynamic>> data - data of Contact 
   * @version 1.0 - 20230112 - initial release
   */
  Future<Map<String, dynamic>> saveContact(Map<String, dynamic> data) async {
    Map<String, dynamic> storage = await storageController.readAppStorage();
    FunctionsClass.printDebug(data);
    List contacts = storage['contacts'];
    Map<String, dynamic> response = {};
    if (!canTheDataBeSaved(data)) {
      return {'success': false, 'checkMandatoryData': true};
    }
    Map<String, dynamic> contact = await createCoordinatesContact(data);
    contacts.add(contact);
    storage['contacts'] = contacts;
    FunctionsClass.printDebug(storage);
    await storageController.writeAppStorage(storage);
    response['success'] = true;

    return {'success': true, 'checkMandatoryData': false};
  }

  /*
   * Delete contact
   * @author  SGV
   * @param <String> id - id of Contact 
   * @version 1.0 - 20230112 - initial release
   */
  Future<void> deleteContact(String id) async {
    Map<String, dynamic> storage = await storageController.readAppStorage();
    List contacts = storage['contacts'];
    for (var contact = 0; contact < contacts.length; contact++) {
      if (id == contacts[contact]['name']) {
        contacts.removeAt(contact);
      }
    }
    storage['contact'] = contacts;
    await storageController.writeAppStorage(storage);
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
    if (data['sobreNome'] == null) {
      return false;
    }
    if (data['endereco'] == null) {
      return false;
    }

    return true;
  }

  /*
   * create coordinates specific of contact
   * @author  SGV
   * @param <Map<String,dynamic>> data - data of Contact 
   * @version 1.0 - 20230116 - initial release
   */
  Future<Map<String, dynamic>> createCoordinatesContact(Map<String, dynamic> data) async {
    String addrees = data['endereco']['endereco'] +' '+data['endereco']['number'] + ', ' + data['endereco']['bairro'] + ', ' + data['endereco']['city'];
    FunctionsClass.printDebug('addrees: $addrees');
    GeoCode geoCode = GeoCode();
    try {
      Coordinates coordinates = await geoCode.forwardGeocoding(address: addrees);
      data['coordinates'] = {'Latitude': coordinates.latitude, 'Longitude': coordinates.longitude};
    } catch (e) {
      data['coordinates'] = {
        'Latitude': '0',
        'Longitude': '0',
      };
    }
    return data;
  }

 /*
  * All markers contacts
  * @author  SGV
  * @param <List> contacts - all contacts
  * @version 1.0 - 20230116 - initial release
  */
  Future<List<Marker>> allMarkersContancts(List contacts) async {
    List<Marker> markers = [];
    for (var contact = 0; contact < contacts.length; contact++) {
      Map<String, dynamic> coordinates = contacts[contact]['coordinates'];
       FunctionsClass.printDebug('coordinates:$coordinates');
      markers.add(
        Marker(
          width: 100,
          height: 100,
          point: LatLng(double.parse(coordinates['Latitude'].toString()), double.parse(coordinates['Longitude'].toString())),
          builder: (ctx) => const Icon(
            Icons.add_location_sharp,
            color: Colors.green,
          ),
          // anchorPos: anchorPos,
        ),
      );
    }
    FunctionsClass.printDebug('markers:$markers');
    return markers;
  }
}
