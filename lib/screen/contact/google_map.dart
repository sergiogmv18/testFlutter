import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geocode/geocode.dart';
import 'package:test/controllers/contact_controller.dart';
import 'package:test/controllers/storage_controller.dart';
import 'package:test/controllers/user_controller.dart';
import '../../helpers/FunctionsClass.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart'; // Suitable for most situations

class GoogleMapScreen extends StatefulWidget {
  final markers;
  const GoogleMapScreen({Key? key, this.markers}) : super(key: key);
  @override
  GoogleMapScreenState createState() => GoogleMapScreenState();
}

class GoogleMapScreenState extends State<GoogleMapScreen> with TickerProviderStateMixin<GoogleMapScreen> {
  List contactList = [];
  bool showProccessLoad = true;
  String? search;
  String? latitude;
  List<Marker> markers = [];
  final StorageController storageController = StorageController();
  final UserController userController = UserController();
  ContactController contactController = ContactController();
  Map<String, dynamic> storage = {};
  GeoCode geoCode = GeoCode();

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
    storage = await storageController.readAppStorage();
    contactList = storage['contacts'];
    markers = widget.markers;
    FunctionsClass.printDebug(markers);

    setState(() {
      showProccessLoad = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async => false, child: getMap());
  }

  getMap() {
    return FlutterMap(
      options: MapOptions(
        keepAlive: true,
        center: LatLng(-25.4875, -49.25548),
        //bounds: LatLngBounds( LatLng(-25.4875, -49.25548)),
        zoom: 9.2,
      ),
      nonRotatedChildren: [
        AttributionWidget.defaultWidget(
          source: 'Stadia Maps © OpenMapTiles © OpenStreetMap contributors',
          onSourceTapped: () async {},
        )
      ],
      children: [
        TileLayer(
          urlTemplate: 'https://tiles.stadiamaps.com/tiles/osm_bright/{z}/{x}/{y}{r}.png',
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(markers: markers),
      ],
    );
  }
}
