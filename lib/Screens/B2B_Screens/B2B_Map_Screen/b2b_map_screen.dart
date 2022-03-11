import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Map_Screen/b2b_map_controller.dart';


class B2BMapScreen extends StatelessWidget {
  // final locationPickerController = Get.find<LocationPickerController>();
  final b2blocationPickerController = Get.put(B2BLocationPickerController());
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
              onPressed: () {
                // pushNewScreen(
                //   context,
                //   screen: HomePage(
                //     pickUpLocation:
                //         b2blocationPickerController.positionCurrent.value,
                //   ),
                //   withNavBar: true,
                //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
                // );
                 Get.back();
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
            height: Get.height - heightappbar,
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      //!-----------------Map
                      Obx(
                         () => Container(
                          child: b2blocationPickerController.isLod.value != true
                                ? GoogleMap(
                                    // polygons: b2blocationPickerController.polygons,
                                    myLocationButtonEnabled: true,
                                    padding: EdgeInsets.only(
                                      top: 60.0,
                                    ),
                                    myLocationEnabled: false,

                                    // 2

                                    initialCameraPosition: CameraPosition(
                                        target: (b2blocationPickerController
                                                    .latitude.value ==
                                                0.0)
                                            ? LatLng(
                                                b2blocationPickerController
                                                    .position!.latitude,
                                                b2blocationPickerController
                                                    .position!.longitude)
                                            : LatLng(
                                                b2blocationPickerController
                                                    .latitude.value,
                                                b2blocationPickerController
                                                    .longitude.value),
                                        zoom: 17),

                                    // 3

                                    mapType: MapType.normal,

                                    onCameraMove: ((_position) {
                                      b2blocationPickerController
                                          .updatePosition(_position);
                                    }),
                                    onCameraIdle: () {
                                      b2blocationPickerController.updateText(
                                          LatLng(
                                              b2blocationPickerController
                                                  .latitude.value,
                                              b2blocationPickerController
                                                  .longitude.value));
                                      print('Darg Stop');
                                    },

                                    // 4

                                    onMapCreated:
                                        b2blocationPickerController.onMapCreated,

                                    markers: Set<Marker>.of(
                                        b2blocationPickerController.markers),
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

  // Widget locationOutChecker() {
  //   return Obx(() => Padding(
  //         padding: const EdgeInsets.symmetric(vertical: 130, horizontal: 10),
  //         child: Align(
  //           alignment: Alignment.topCenter,
  //           child: (b2blocationPickerController.isInPolygon!.value)
  //               ? UnconstrainedBox()
  //               : Container(
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(10),
  //                     color: Colors.red.withOpacity(0.9),
  //                   ),
  //                   padding: EdgeInsets.all(5),
  //                   child: Text(
  //                     'Oops! we are not operating in this area.',
  //                     style: TextStyle(fontSize: 18, color: Colors.white),
  //                   ),
  //                 ),
  //         ),
  //       ));
  // }

  Widget searchTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        children: [
          Align(
            //!----------------------Search Box
            alignment: Alignment.topCenter,
            child: TextField(
              controller: b2blocationPickerController.addresscontroller,
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
                  //     (val) => b2blocationPickerController.findPlace(value, true));
                  b2blocationPickerController.findPlace(
                    value,
                  );
                  b2blocationPickerController.autoCompleteSearchVisibilty.value =
                      true;
                } else if (value.isEmpty) {
                  print('Empty');
                  b2blocationPickerController.findPlace(
                    value,
                  );
                  b2blocationPickerController.addresscontroller.text = '';
                  b2blocationPickerController.predictions.clear();
                  b2blocationPickerController.autoCompleteSearchVisibilty.value =
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
                    b2blocationPickerController.autoCompleteSearchVisibilty.value,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: b2blocationPickerController.predictions.length,
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
                                b2blocationPickerController.predictions[index]),
                            onTap: () {
                              b2blocationPickerController.searchAndNavigate(
                                  b2blocationPickerController.predictions[index]);
                              b2blocationPickerController.addresscontroller.text =
                                  b2blocationPickerController.predictions[index];
                              b2blocationPickerController
                                  .autoCompleteSearchVisibilty.value = false;
                              b2blocationPickerController.predictions.clear();
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
