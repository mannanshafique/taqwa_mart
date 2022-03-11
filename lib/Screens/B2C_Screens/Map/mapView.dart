import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Checkout/checkout_screen.dart';
import 'package:mangalo_app/Screens/B2C_Screens/HomePage/BottomNavigation/BottomNavigation.dart';
import 'package:mangalo_app/Screens/B2C_Screens/HomePage/HomePage_Controller/homepage_controller.dart';
import 'package:mangalo_app/Screens/B2C_Screens/HomePage/homepage.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Map/Map_Controller/mapController.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapScreen extends StatelessWidget {
  final bool isFromHomePage;
  final bool isFromCheckout;
  MapScreen({required this.isFromHomePage, required this.isFromCheckout});
  // final locationPickerController = Get.find<LocationPickerController>();
  final locationPickerController = Get.put(LocationPickerController());
  final homePageController = Get.put(HomePageController());
  @override
  Widget build(BuildContext context) {
    var heightappbar = MediaQuery.of(context).padding.top + kToolbarHeight;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Select Location',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          actions: [
            IconButton(
              onPressed: () async {
                print(
                    'Check Icon ${locationPickerController.positionCurrent.value}');
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.setString('updatedAddress',
                    locationPickerController.positionCurrent.value);
                if (isFromCheckout) {
                  Get.back();
                  // Get.dialog(CheckOutScreen());
                }
                (isFromHomePage)
                    ? pushNewScreen(
                        context,
                        screen: HomePage(
                          pickUpLocation:
                              locationPickerController.positionCurrent.value,
                        ),
                        withNavBar: true,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      )
                    : (isFromCheckout)
                        ? Get.dialog(CheckOutScreen())
                        : pushNewScreen(
                            context,
                            screen: BottomNavigation(
                              initailIndex: 0,
                            ),
                            withNavBar: true,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );

                // Get.to(()=> HomePage(pickUpLocation: locationPickerController.positionCurrent.value,));
              },
              icon: Icon(
                Icons.check,
                color: blackColor,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            height: (isFromCheckout)
                ? Get.height - heightappbar
                : Get.height - heightappbar * 1.7,
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      //!-----------------Map
                      Obx(
                        () => Container(
                            child: locationPickerController.isLod.value != true
                                ? GoogleMap(
                                    // polygons: locationPickerController.polygons,
                                    myLocationButtonEnabled: true,
                                    padding: EdgeInsets.only(
                                      top: 60.0,
                                    ),
                                    myLocationEnabled: false,

                                    // 2

                                    initialCameraPosition: CameraPosition(
                                        target: (locationPickerController
                                                    .latitude.value ==
                                                0.0)
                                            ? LatLng(
                                                locationPickerController
                                                    .position!.latitude,
                                                locationPickerController
                                                    .position!.longitude)
                                            : LatLng(
                                                locationPickerController
                                                    .latitude.value,
                                                locationPickerController
                                                    .longitude.value),
                                        zoom: 17),

                                    // 3

                                    mapType: MapType.normal,

                                    onCameraMove: ((_position) {
                                      locationPickerController
                                          .updatePosition(_position);
                                    }),
                                    onCameraIdle: () {
                                      locationPickerController.updateText(
                                          LatLng(
                                              locationPickerController
                                                  .latitude.value,
                                              locationPickerController
                                                  .longitude.value));
                                      print('Darg Stop');
                                    },

                                    // 4

                                    onMapCreated:
                                        locationPickerController.onMapCreated,

                                    markers: Set<Marker>.of(
                                        locationPickerController.markers),
                                  )
                                : Center(
                                    child: CircularProgressIndicator(),
                                  )),
                      ),
                      //!-------Error message if out from polygon
                      // locationOutChecker(),
                      //! ----------------Search
                      searchTextField(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget locationOutChecker() {
    return Obx(() => Padding(
          padding: const EdgeInsets.symmetric(vertical: 130, horizontal: 10),
          child: Align(
            alignment: Alignment.topCenter,
            child: (locationPickerController.isInPolygon!.value)
                ? UnconstrainedBox()
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red.withOpacity(0.9),
                    ),
                    padding: EdgeInsets.all(5),
                    child: Text(
                      'Oops! we are not operating in this area.',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
          ),
        ));
  }

  Widget searchTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        children: [
          Align(
            //!----------------------Search Box
            alignment: Alignment.topCenter,
            child: TextField(
              controller: locationPickerController.addresscontroller,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Color(0xFFF2F2F2),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(width: 1.3, color: Colors.grey),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(width: 1.3, color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(width: 1.3, color: Colors.grey),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                      width: 1.3,
                    )),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(width: 1.3, color: Colors.black)),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(width: 1.3, color: Colors.grey)),
                hintText: "Search",
                hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                contentPadding: EdgeInsets.all(0),
              ),
              onChanged: (value) async {
                print(value);
                if (value.isNotEmpty) {
                  // Future.delayed(Duration(seconds: 2)).then(
                  //     (val) => locationPickerController.findPlace(value, true));
                  locationPickerController.findPlace(
                    value,
                  );
                  locationPickerController.autoCompleteSearchVisibilty.value =
                      true;
                } else if (value.isEmpty) {
                  print('Empty');
                  locationPickerController.findPlace(
                    value,
                  );
                  locationPickerController.addresscontroller.text = '';
                  locationPickerController.predictions.clear();
                  locationPickerController.autoCompleteSearchVisibilty.value =
                      false;
                }
              },
            ),
          ),
          SizedBox(
            height: 5,
          ),
          //!----------------------------------
          Obx(() => Visibility(
                //!----------------------Result List
                visible:
                    locationPickerController.autoCompleteSearchVisibilty.value,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: locationPickerController.predictions.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              child: Icon(
                                Icons.pin_drop,
                                color: Colors.grey,
                              ),
                            ),
                            title: Text(
                                locationPickerController.predictions[index]),
                            onTap: () {
                              locationPickerController.searchAndNavigate(
                                  locationPickerController.predictions[index]);
                              locationPickerController.addresscontroller.text =
                                  locationPickerController.predictions[index];
                              locationPickerController
                                  .autoCompleteSearchVisibilty.value = false;
                              locationPickerController.predictions.clear();
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
