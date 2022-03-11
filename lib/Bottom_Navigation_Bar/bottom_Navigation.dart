// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:mangalo_app/Screens/User_Mode_Screen/user_mode_screen.dart';

// import 'bottom_navigation_items.dart';
// import 'bottom_navigation_screens.dart';

// class BottomNavigationView extends StatelessWidget {
//   const BottomNavigationView({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoTabScaffold(
//       tabBar: CupertinoTabBar(items: bottomNavigationItems(context),), 
//       tabBuilder: (context,index){
//         switch(index){
//           case 0: 
//           return CupertinoTabView(builder: (context){
//           return CupertinoPageScaffold(child: UserModeScreen());
//         },);
//           case 1: 
//           return CupertinoTabView(builder: (context){
//           return CupertinoPageScaffold(child: UserModeScreen());
//         },);
//           case 2: 
//           return CupertinoTabView(builder: (context){
//           return CupertinoPageScaffold(child: UserModeScreen());
//         },);
//           case 3: 
//           return CupertinoTabView(builder: (context){
//           return CupertinoPageScaffold(child: UserModeScreen());
//         },);
//           default : 
//           return CupertinoTabView(builder: (context){
//           return CupertinoPageScaffold(child: HomePage(pickUpLocation: 'pickUpLocation'));
//         },);

//         }
        
//       });
//   }
// }