import 'package:e_commerce_app/screens/account_screen/account_screen.dart';
import 'package:e_commerce_app/screens/cart/cart_screen.dart';
import 'package:e_commerce_app/screens/favorite/favorite_screen.dart';
import 'package:e_commerce_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({final Key? key,})
      : super(key: key);


  @override
  _CustomBottomBar createState() => _CustomBottomBar();
}

class _CustomBottomBar extends State<CustomBottomBar> {
  PersistentTabController _controller = PersistentTabController();
  bool _hideNavBar = false;

  List<Widget> _buildScreens() => [
    const Home(),
    const CartScreen(),
    const FavoriteScreen(),
     AccountScreen(),
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
    PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        inactiveIcon: const Icon(Icons.home_outlined),
        title: "Home",
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
        ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.shopping_cart),
      inactiveIcon: const Icon(Icons.shopping_cart_outlined),
      title: "Cart",
      activeColorPrimary: Colors.white,
      inactiveColorPrimary: Colors.white,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.favorite),
      inactiveIcon: const Icon(Icons.favorite_border),
      title: "Favorite",
      activeColorPrimary: Colors.white,
      inactiveColorPrimary: Colors.white,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.person),
      inactiveIcon: const Icon(Icons.person_outlined),
      title: "Account",
      activeColorPrimary: Colors.white,
      inactiveColorPrimary: Colors.white,
    ),
  ];

  @override
  Widget build(final BuildContext context) => Scaffold(
    body: PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      resizeToAvoidBottomInset: true,
      navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
          ? 0.0
          : kBottomNavigationBarHeight,
      bottomScreenMargin: 0,
      backgroundColor: Colors.green,
      hideNavigationBar: _hideNavBar,
      decoration: const NavBarDecoration(colorBehindNavBar: Colors.indigo),
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
      ),
      navBarStyle: NavBarStyle
          .style1, // Choose the nav bar style with this property
    ),
  );
}