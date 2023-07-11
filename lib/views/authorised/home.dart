import 'package:club_admin/views/authorised/registerResto.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedindex = 0;
  int currentIndex = 0;
  PageController controller = PageController(initialPage: 0);
  List tabs = [
    const Center(
      child: Text("Dashboard"),
    ),
    const Center(
      child: Text('Menu'),
    ),
    const Center(
      child: registerResto(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    dynamic height = MediaQuery.sizeOf(context).height;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: tabs[selectedindex],
          ),
          bottomNavigationBar: FlashyTabBar(
            showElevation: true,
            selectedIndex: selectedindex,
            animationCurve: Curves.easeInCubic,
            onItemSelected: (index) {
              setState(() {
                selectedindex = index;
              });
            },
            backgroundColor: Colors.white,
            height: height * 0.08,
            iconSize: height * 0.02,
            items: [
              FlashyTabBarItem(
                icon: Icon(
                  Icons.dashboard_rounded,
                  color: Colors.black,
                  size: height * 0.027,
                ),
                title: Text(
                  'Dashboard',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              FlashyTabBarItem(
                icon: Icon(
                  Icons.turned_in_rounded,
                  color: Colors.black,
                  size: height * 0.03,
                ),
                title: Text(
                  'Manue',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              FlashyTabBarItem(
                icon: Icon(
                  Icons.person,
                  size: height * 0.03,
                  color: Colors.black,
                ),
                title: Text(
                  'Review',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          )),
    );
  }
}
