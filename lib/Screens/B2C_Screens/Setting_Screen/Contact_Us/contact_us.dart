import 'package:flutter/material.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        toolbarHeight: 100,
        backgroundColor: greenColor,
        title: Text(
          'Contact Us',
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
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Image.asset('assets/Images/contact_us.png'),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                detailListtile(Icons.email, 'Email', 'info@'),
                GestureDetector(
                    onTap: () {
                      // makePhoneCall('tel:+923332918981');
                    },
                    child: detailListtile(
                        Icons.phone, 'Mobile no', '0333-0000000')),
                // detailListtile(Icons.location_on, 'Address', 'Plot 4/b Karsaz'),
              ],
            ),
          )
        ],
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
