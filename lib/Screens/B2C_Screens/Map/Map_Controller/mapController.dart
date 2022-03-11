import 'dart:collection';
import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as toolkit;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LocationPickerController extends GetxController {
  String apiKey = 'AIzaSyDzjTWsPSJ0375eY37C0K9hWOrV9W-2TuU';
  var positionCurrent = ''.obs;
  // var country = ''.obs;
  // var countryCode = ''.obs;
  // var city = ''.obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  // var address = ''.obs;
  Position? position;
  RxBool isLod = true.obs;
  final TextEditingController addresscontroller = TextEditingController();

  List<Marker> markers = <Marker>[].obs;
  GoogleMapController? mapController;
  BitmapDescriptor? mapMaker;
//!--
  RxList predictions = [].obs;
  // GooglePlace? googlePlace;
  RxBool autoCompleteSearchVisibilty = false.obs;

//!---------------For Polygon Addition------------

  RxBool? isInPolygon = false.obs;

  Set<Polygon> polygons = HashSet<Polygon>();

  List<LatLng> polygonLatLng = <LatLng>[
    LatLng(24.860321, 67.064482),
    LatLng(24.863567, 67.075004),
    LatLng(24.858308, 67.076717),
    LatLng(24.854917, 67.067096),
  ];

  setPolygon() {
    polygons.add(Polygon(
        polygonId: PolygonId('poly1'),
        points: polygonLatLng,
        fillColor: Colors.orange.withOpacity(0.3),
        strokeColor: Colors.red,
        strokeWidth: 5));
  }

  checkIsInPolygon(latlong) {
    List<toolkit.LatLng> polygon = <toolkit.LatLng>[
      toolkit.LatLng(24.860321, 67.064482),
      toolkit.LatLng(24.863567, 67.075004),
      toolkit.LatLng(24.858308, 67.076717),
      toolkit.LatLng(24.854917, 67.067096),
    ];

    isInPolygon!.value =
        toolkit.PolygonUtil.containsLocation(latlong, polygon, false);
    print(
        '------------------------------------------------${isInPolygon!.value}');
    update();
  }

//!--------------End Polygon-------------

//!----Set Custom Marker
  void setCustomMarker() async {
    mapMaker = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      'assets/Images/locationIcon.png',
    );
  }

//! Fetch current location
  currentPost() async {
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      try {
        updateText(LatLng(position!.latitude, position!.longitude));
        checkIsInPolygon(
            toolkit.LatLng(position!.latitude, position!.longitude));
      } catch (e) {
        print(e);
      }
    } catch (e) {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        try {
          updateText(LatLng(position!.latitude, position!.longitude));
          checkIsInPolygon(
              toolkit.LatLng(position!.latitude, position!.longitude));
        } catch (e) {
          print(e);
        }
      }
      print(e);
      print('Presmission Denied');
    }
  }

//! Update Postion on Map Drag-------------------------------------------------
  void updatePosition(CameraPosition _position) async {
    Marker marker = markers[0];

    markers[0] = marker.copyWith(
        positionParam:
            LatLng(_position.target.latitude, _position.target.longitude));

    latitude.value = _position.target.latitude;
    longitude.value = _position.target.longitude;

    checkIsInPolygon(
        toolkit.LatLng(_position.target.latitude, _position.target.longitude));
  }

//! Update Location Address on Marker Drag----------------------------------
  updateText(LatLng newMarkPosition) async {
    List<Placemark> p = await placemarkFromCoordinates(
        newMarkPosition.latitude, newMarkPosition.longitude);

    Placemark place = p[0];

    // city.value = place.locality!;
    // country.value = place.country!;
    // countryCode.value = place.isoCountryCode!;

    positionCurrent.value =
        "${place.name}, ${place.subLocality}, ${place.country}";
    isLod.value = false;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('updatedAddress', positionCurrent.value);
    sharedPreferences.setString('userLat', newMarkPosition.latitude.toString());
    sharedPreferences.setString(
        'userLong', newMarkPosition.longitude.toString());
    addresscontroller.text = positionCurrent.value;
    print('Position current from map Controller ${positionCurrent.value}');
    print('---------------------------------------------------------');
    update();
  }

//!--------When Initialiy Map Created------------------------------
  void onMapCreated(GoogleMapController controller) {
    print('Map Created');

    if (longitude.value == 0.0 && latitude.value == 0.0) {
      mapController = controller;
      markers.clear();
      markers.add(Marker(
        visible: true,
        draggable: true,
        markerId: MarkerId('id101'),
        icon: mapMaker!,
        position: LatLng(position!.latitude, position!.longitude),
      ));
    } else {
      mapController = controller;
      markers.clear();
      markers.add(Marker(
        visible: true,
        draggable: true,
        markerId: MarkerId('id101'),
        icon: mapMaker!,
        position: LatLng(latitude.value, longitude.value),
      ));
    }

    update();
  }

//!------------Search AND Navigate on Onclick  on Google Map

  void findPlace(
    String placeName,
  ) async {
    if (placeName.length > 2) {
      String autoCompleteUrl =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$apiKey&components=country:pk';
      var res = await http.get(Uri.parse(autoCompleteUrl));
      if (res.statusCode == 200) {
        predictions.value = [];
        var jsonData = jsonDecode(res.body);

        if (jsonData['status'] == 'OK') {
          predictions.clear();

          for (int i = 0; i < jsonData['predictions'].length; i++) {
            predictions.add(jsonData['predictions'][i]['description']);
            print(res.body);
          }
          update();
        } else {}
      } else {
        print('Error--------------------------------------------');
      }
    }
  }

  searchAndNavigate(address) async {
    // print(address);
    try {
      // print(address);
      await locationFromAddress(address).then((value) async {
        mapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(value[0].latitude, value[0].longitude),
            zoom: 17,
          ),
        ));
      });
    } catch (e) {
      // return Fluttertoast.showToast(msg: 'No such location');
      print('No such location');
    }
  }

//!--------Oninit

  @override
  void onInit() {
    setPolygon();
    currentPost();
    setCustomMarker();

    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
