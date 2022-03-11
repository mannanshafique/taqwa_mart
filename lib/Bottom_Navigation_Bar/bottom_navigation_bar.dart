
// import 'package:flutter/material.dart';
// import 'package:mangalo_app/Bottom_Navigation_Bar/bottom_navigation_items.dart';
// import 'package:mangalo_app/Bottom_Navigation_Bar/bottom_navigation_screens.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

// class BottomPresistentNavigationBar extends StatelessWidget {
//  BottomPresistentNavigationBar({ Key? key }) : super(key: key);

//   final navigationcontroller = PersistentTabController(initialIndex: 0);

//   @override
//   Widget build(BuildContext context) {
//     return PersistentTabView(
      
//         context,
//         controller: navigationcontroller,
//         screens: bottomNavigationScreens(),
//         items: bottomNavigationItems(context),
//         confineInSafeArea: true,
//         backgroundColor: Colors.white, // Default is Colors.white.
//         handleAndroidBackButtonPress: true, // Default is true.
//         resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
//         stateManagement: true, // Default is true.
//         hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
//         decoration: NavBarDecoration(
//           borderRadius: BorderRadius.circular(10.0),
//           colorBehindNavBar: Colors.white,
//         ),
//         popAllScreensOnTapOfSelectedTab: true,
//         popActionScreens: PopActionScreensType.all,
//         itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
//           duration: Duration(milliseconds: 200),
//           curve: Curves.ease,
//         ),
//         screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
//           animateTabTransition: true,
//           curve: Curves.ease,
//           duration: Duration(milliseconds: 200),
//         ),
//         navBarStyle: NavBarStyle.style15, // Choose the nav bar style with this property.
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BottomNavigationBar bottomNavigationBar( int _selectedIndex, 
Function(int) _onItemTapped) {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.settings),
        // activeIcon: ImageIcon(AssetImage('Assets/images/Home_Icon_Blue.png')),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.settings),
        activeIcon:
            ImageIcon(AssetImage('Assets/images/Locator_Icon_Blue.png')),
        label: 'Locator',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.settings),
        activeIcon:
            ImageIcon(AssetImage('Assets/images/Explore_Icon_Blue.png')),
        label: 'Explore',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.settings),
        activeIcon:
            ImageIcon(AssetImage('Assets/images/Loyalty_Icon_Blue.png')),
        label: 'Loyalty',
      ),
    ],
    elevation: 10,
    backgroundColor: Colors.white,
    currentIndex: _selectedIndex,
    selectedItemColor: Colors.purple,
    showUnselectedLabels: true,
    unselectedItemColor: Colors.grey,
    onTap: _onItemTapped,
  );
}
