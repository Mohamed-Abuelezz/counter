import 'package:counter/Screens/edit_account/editAccountScreen.dart';
import 'package:counter/Screens/home/homeScreen.dart';
import 'package:counter/Screens/more/moreScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  PersistentTabController? _controller;

  List<Widget> _buildScreens() => [
        HomeScreen(),
        EditAccountScreen(),
        MoreScreen(),
      ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
            icon: const Icon(CupertinoIcons.home),
            title: "Home",
            activeColorPrimary: Colors.black,
            inactiveColorPrimary: Colors.grey,
            inactiveColorSecondary: Colors.purple),
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.person),
          title: "Account",
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.ellipsis_circle),
          title: "More",
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.grey,
        ),
      ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      // padding: NavBarPadding.symmetric(horizontal: 20),
      screens: _buildScreens(), selectedTabScreenContext: (p0) {},
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      
      popAllScreensOnTapOfSelectedTab: false,
      popActionScreens: PopActionScreensType.once,

      navBarHeight: 75,
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: false, // Default is true.
      popAllScreensOnTapAnyTabs: true,
      //     popActionScreens: PopActionScreensType.once,

      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(spreadRadius: .2, blurRadius: 2, color: Colors.grey)
        ],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        colorBehindNavBar: Colors.white,
      ),
      //  popAllScreensOnTapOfSelectedTab: false,
      //   popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),

        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style5, // Choose the nav bar style with this property.
    );
  }
}
