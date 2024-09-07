import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:pradhangroup/Screens/Listing.dart';
import 'package:pradhangroup/Screens/favourites.dart';
import 'package:pradhangroup/Screens/profile.dart';
import 'package:pradhangroup/functions/firebase_functions.dart';

import 'FuncScreen/postDetails.dart';
import 'Screens/Search.dart';
import 'Screens/HomeScreen.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _homeState();
}


class _homeState extends State<NavigationMenu> {

  // store the current user id from firebase in get storage 

  void storeUser() async {
    final box = GetStorage();
    final user = FirebaseAuth.instance.currentUser;

    // fetch data from firebase and store it in get storage as this user uid exists in the users collection
    // so we can fetch the data from the users collection using this uid

   var userData = await FirebaseFunctions().fetchUserbyID(user!.uid);
    // await box.write('name', userData!.name);
    // await box.write('phoneNo', userData.phoneNo);
    // await box.write('createdAt', userData.createdAt);
    // await box.write('isVerified', userData.isVerified);
    // await box.write('uid', userData.uid);


    log("User data : ${box.read('name')}");
    log("User data : ${box.read('phoneNo')}");
    log("User data : ${box.read('createdAt')}");
    log("User data : ${box.read('isVerified')}");
  }

  @override
  void initState() { 
    storeUser();
    super.initState();
    
    // log("Current User ID : ${getUser().then((value) => value!.uid.toString())}");
  }

  PersistentTabController _controller = PersistentTabController(initialIndex: 0);
  int pp = 0;
  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      FavouriteScreen(),
      Search(),
      Listing(),
      Profile(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    print(_controller.index);
    return [
      PersistentBottomNavBarItem(
        icon: Padding(
          padding: const EdgeInsets.all(6.0),
          child: (pp == 0)?Image.asset('assets/bottom/Homec.png'):Image.asset('assets/bottom/Home.png'),
        ),
        title: "Home",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Padding(
          padding: const EdgeInsets.all(6.0),
          child: (pp == 1)?Image.asset('assets/bottom/Heartc.png'):Image.asset('assets/bottom/Heart.png'),
        ),
        title: "Settings",
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Padding(
          padding: const EdgeInsets.all(6.0),
          child: (pp == 2)?Image.asset('assets/bottom/Searchp.png'):Image.asset('assets/bottom/Search.png'),
        ),
        title: "Settings",
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Padding(
          padding: const EdgeInsets.all(6.0),
          child: (pp ==3)?Image.asset('assets/bottom/Listc.png'):Image.asset('assets/bottom/List.png'),
        ),
        title: "Settings",
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Padding(
          padding: const EdgeInsets.all(6.0),
          child: (pp == 4)?Image.asset('assets/bottom/Userc.png'):Image.asset('assets/bottom/User.png'),
        ),
        title: "Settings",
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }



  @override
  Widget build(BuildContext context) {


    return PersistentTabView(

      context,
      controller: _controller,
      onItemSelected: (_c){
        setState(() {
          pp = _controller.index;
        });

      },
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style12, // Choose the nav bar style with this property.
    );

  }
}
