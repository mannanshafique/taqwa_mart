import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Constant/Widgets/common_widget.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Listing/b2b_listing_controller.dart';

class B2BListing extends StatefulWidget {
  B2BListing({Key? key}) : super(key: key);


  @override
  State<B2BListing> createState() => _B2BListingState();
}

class _B2BListingState extends State<B2BListing> {
  final ListingController _listingController = Get.put(ListingController());
   GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CommonWidget()
            .customText('Rate List', blackColor, 20.0, FontWeight.w500, 1),
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 50),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 2,
                    child: Form(
                      key: _formkey,
                      child: TextFormField(
                        controller:
                            _listingController.maundTextEditingController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            isDense: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(
                                  width: 1, color: blackColor.withOpacity(0.5)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(
                                  width: 1, color: blackColor.withOpacity(0.5)),
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(
                                  width: 1,
                                )),
                            hintText: 'Value'),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Enter the Value";
                          }
                        },
                      ),
                    )),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(flex: 3, child: dropDownc()),
                IconButton(
                    iconSize: 30.0,
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        _listingController.isLoading.value = true;
                        FocusScope.of(context).requestFocus(FocusNode());
                        _listingController.postRbd(
                            maundRate: _listingController
                                .maundTextEditingController.text,
                            type: _listingController.currentrbdItem.value);
                      }
                    },
                    icon: Icon(Icons.search))
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(() => (_listingController.isLoading.value)
            ? Center(
                child: CircularProgressIndicator(
                  color: greenColor,
                ),
              )
            : (_listingController.rbdListing.isEmpty)
                ? Center(
                    child: CommonWidget().customText(
                        'Nothing Found', blackColor, 20.0, FontWeight.w500, 1),
                  )
                : ListView(
                    children: [
                      DataTable(
                          columns: [
                            DataColumn(
                                label: Text(
                              'Brand',
                              style: TextStyle(
                                  color: blackColor,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            )),
                            DataColumn(
                                label: Text(
                              'Rate',
                              style: TextStyle(
                                  color: blackColor,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            )),
                          ],
                          rows: _listingController.rbdListing
                              .map((e) => DataRow(cells: <DataCell>[
                                    DataCell(Text(e.brand.toString())),
                                    DataCell(Text(e.rate.toString())),
                                  ]))
                              .toList())
                    ],
                  )),
      ),
    );
  }

  Widget dropDownc() {
    return Obx(() => Theme(
        data: ThemeData(canvasColor: whiteColor),
        child: DropdownButtonFormField(
            elevation: 0,
            isDense: true,
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                )),
            value: _listingController
                .currentrbdItem.value, //shows the selected value
            items: _listingController.rbdItems.map((e) {
              //e is varaible for list sugar define above
              return DropdownMenuItem(
                child: Text('$e'),
                value: e,
              );
            }).toList(),
            onChanged: (val) {
              _listingController.currentrbdItem.value = val.toString();
              _listingController.maundTextEditingController.clear();
            })));
  }
}
