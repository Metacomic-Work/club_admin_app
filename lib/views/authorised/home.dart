import 'package:club_admin/constants/homeConstants.dart';
import 'package:club_admin/views/authorised/registerResto.dart';
import 'package:club_admin/views/authorised/tabs/homePage.dart';
import 'package:club_admin/views/authorised/tabs/menuPage.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  int selectedindex = 0;
  int currentIndex = 0;
  PageController controller = PageController(initialPage: 0);
  List tabs = [
    const Center(
      child: HomePage(),
    ),
    const Center(
      child: MenuPage(),
    ),
    const Center(
      child: Center(child: Text("Temp"),),
    ),
    const Center(
      child: Text('Menu'),
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
            items: HomeConstants.flashyTabBarItems
          )
        ),
    );
  }
}