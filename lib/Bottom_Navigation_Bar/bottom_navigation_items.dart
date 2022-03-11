import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

List<BottomNavigationBarItem> bottomNavigationItems(context) {
        return [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home),
             label: 'home',
            ),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings),
                label: 'home',
               
            ),
            BottomNavigationBarItem(
              
                icon: Icon(CupertinoIcons.home),
                label: 'home',
                 ),
            
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings),
               label: 'home',
            ),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings),
               label: 'home',
            ),
        ];
    }
// List<PersistentBottomNavBarItem> bottomNavigationItems(context) {
//         return [
//             PersistentBottomNavBarItem(
//                 icon: Icon(CupertinoIcons.home),
//                 title: ("Home"),
//                 activeColorPrimary: CupertinoColors.activeBlue,
//                 inactiveColorPrimary: CupertinoColors.systemGrey,
//             ),
//             PersistentBottomNavBarItem(
//                 icon: Icon(CupertinoIcons.settings),
//                 title: ("Settings"),
//                 activeColorPrimary: CupertinoColors.activeBlue,
//                 inactiveColorPrimary: CupertinoColors.systemGrey,
//             ),
//             PersistentBottomNavBarItem(
              
//                 icon: Icon(CupertinoIcons.home),
//                 title: ("Home"),
//                 activeColorPrimary: CupertinoColors.activeBlue,
//                 inactiveColorPrimary: CupertinoColors.systemGrey,
//                  ),
            
//             PersistentBottomNavBarItem(
//                 icon: Icon(CupertinoIcons.settings),
//                 title: ("Settings"),
//                 activeColorPrimary: CupertinoColors.activeBlue,
//                 inactiveColorPrimary: CupertinoColors.systemGrey,
//             ),
//             PersistentBottomNavBarItem(
//                 icon: Icon(CupertinoIcons.settings),
//                 title: ("Settings"),
//                 activeColorPrimary: CupertinoColors.activeBlue,
//                 inactiveColorPrimary: CupertinoColors.systemGrey,
//             ),
//         ];
//     }