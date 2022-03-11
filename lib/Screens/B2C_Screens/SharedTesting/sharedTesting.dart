// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:mangalo_app/Screens/Cart/Cart_Controller/cart_controller.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SharedTesting extends StatefulWidget {
//   const SharedTesting({Key? key}) : super(key: key);

//   @override
//   _SharedTestingState createState() => _SharedTestingState();
// }

// class _SharedTestingState extends State<SharedTesting> {
//   SharedPref sharedPref = SharedPref();
//   var userLoad;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           height: 800,
//           child: Column(
//             children: [
//               ElevatedButton(
//                   onPressed: () {
//                     loadSharedPrefs();
//                     print('Read Clicked');
//                   },
//                   child: Text('Read')),
//               ElevatedButton(
//                   onPressed: () {
//                     print('Delete Clicked');
//                     deletaData();
//                   },
//                   child: Text('Remove')),
//               ElevatedButton(
//                   onPressed: () {
//                     print('Save Clicked');
//                     saveSharedPref();
//                   },
//                   child: Text('Save')),
//               userLoad != null
//                   ? SizedBox(
//                       height: 300.0,
//                       child: Wrap(
//                         // crossAxisAlignment: CrossAxisAlignment.center,
//                         // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: <Widget>[
//                           Text("Name: " + (userLoad.name.toString()),
//                               style: TextStyle(fontSize: 16)),
//                         ],
//                       ),
//                     )
//                   : Center(
//                       child: CircularProgressIndicator(),
//                     ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   loadSharedPrefs() async {
//     print('Inner Load Clicked');
//     try {
//       CartModel user = CartModel.fromJson(await sharedPref.read("user1"));
//       // List user = await sharedPref.read("user0");
//       print('its user ----read$user');
//       setState(() {
//         userLoad = user;
//       });
//     } catch (Excepetion) {
//       print(Excepetion);
//       print('Its Exception of load');
//     }
//   }

//   saveSharedPref() async {
//     print('Inner Save Clicked');
//     List<CartModel> userSave = [
//       CartModel('data', 2, '200', isInCart: true, id: 01),
//       CartModel('ali', 3, '600', isInCart: true, id: 02),
//       CartModel('hassan', 5, '100', isInCart: true, id: 03),
//       CartModel('name sfas', 7, '50', isInCart: true, id: 04),
//     ];
//     for (int i = 0; i < userSave.length; i++) {
//       try {
//         await sharedPref.save("user$i", userSave[i]);
//       } catch (Excepetion) {
//         print(Excepetion);
//       }
//     }
//   }

//   deletaData() async {
//     print('Inner Delete Clicked');
//     try {
//       await sharedPref.remove("user1");
//     } catch (Excepetion) {
//       print(Excepetion);
//     }
//   }
// }

// class SharedPref {
//   read(String key) async {
//     final prefs = await SharedPreferences.getInstance();
//     return json.decode(prefs.getString(key)!);
//   }

//   save(String key, value) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString(key, json.encode(value));
//   }

//   remove(String key) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.remove(key);
//   }
// }
