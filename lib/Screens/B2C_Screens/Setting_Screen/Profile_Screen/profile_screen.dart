import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Constant/Widgets/common_widget.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Setting_Screen/Profile_Screen/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        toolbarHeight: 100,
        backgroundColor: greenColor,
        title: Text(
          'Profile',
          style: TextStyle(color: whiteColor, fontSize: 25.0),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(40),
          bottomLeft: Radius.circular(40),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Profile',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.dialog(EditingAlertDialogue(
                        profileController: profileController,
                      )).then((value) =>
                          profileController.phoneTextEditingController.clear());
                    },
                    child: Wrap(
                      children: [
                        Text(
                          'Edit',
                          style: TextStyle(fontSize: 20.0, color: greenColor),
                        ),
                        CommonWidget().sizedBox(0.0, 5.0),
                        Icon(
                          Icons.edit,
                          color: greenColor,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Obx(() => (profileController.isLoading.value)
                  ? Center(
                      child: CircularProgressIndicator(
                        color: greenColor,
                      ),
                    )
                  : Column(
                      children: [
                        //!-------****Detail
                        detailListtile(Icons.person, 'Full Name',
                            profileController.fullName.value),
                        detailListtile(Icons.email, 'Email',
                            profileController.email.value),
                        detailListtile(Icons.phone, 'Mobile no',
                            profileController.mobileNo.value),
                        detailListtile(Icons.location_on, 'Address',
                            profileController.address.value),
                      ],
                    ))
            ],
          ),
        ),
      ),
    );
  }

  Widget detailListtile(icon, title, subtitle) {
    return ListTile(
      horizontalTitleGap: 0,
      leading: Icon(
        icon,
        color: greenColor,
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 18.0, color: Colors.grey),
      ),
      subtitle: Text(
        subtitle,
        maxLines: 2,
        style: TextStyle(fontSize: 20.0, color: Colors.black),
      ),
    );
  }
}


