import 'package:club_admin/constants/homeConstants.dart';
import 'package:club_admin/controllers/mediaControllers.dart';
import 'package:club_admin/views/authorised/registerResto.dart';
import 'package:club_admin/views/authorised/tabs/event_list_screen.dart';
import 'package:club_admin/views/authorised/tabs/eventsPage.dart';
import 'package:club_admin/views/authorised/tabs/homePage.dart';
import 'package:club_admin/views/authorised/tabs/menuPage.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../controllers/homeController.dart';
import '../../controllers/menuItemsController.dart';
import '../../controllers/restaurantController.dart';
import '../../services/notificationServices.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  RestaurantController restaurantController = Get.put(RestaurantController());
  MenuItemController menuItemController = Get.put(MenuItemController());
  HomeController homeController = Get.put(HomeController());
  MediaController mediaController = Get.put(MediaController());
  NotificationServices notificationServices = NotificationServices();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    InitializeHomeScreen();
    
  }

  bool isLoading = false;
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
      EventsScreen(),
    const Center(
      child: RegisterRestaurant(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    dynamic height = MediaQuery.sizeOf(context).height;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Skeletonizer(
            enabled: isLoading,
            child: Center(
              child: tabs[selectedindex],
            ),
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

  Future InitializeHomeScreen() async{
    setState(() {
      isLoading = true;
    });
    await homeController.getBookings();
    await restaurantController.getRestaurantData();
    await menuItemController.getMenuItemStream();
    await mediaController.getRestaurantImagesStream();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(BuildContext);
    notificationServices.setupInteractMessage(BuildContext);
    notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value){
      print("Device token $value");
    });
    setState(() {
      isLoading = false;
    });
  }
}
