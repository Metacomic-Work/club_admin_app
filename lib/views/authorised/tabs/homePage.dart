import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_admin/controllers/authController.dart';
import 'package:club_admin/controllers/homeController.dart';
import 'package:club_admin/controllers/restaurantController.dart';
import 'package:club_admin/controllers/userController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

    UserController userController = Get.put(UserController());
    HomeController homeController = Get.put(HomeController());
    AuthController authController = Get.put(AuthController());
    bool toggle = false;



  @override
  void initState() {
    super.initState();
    homeController.checkTotalRestaurants();
    authController.getUserId();
    print("Current User Id${userController.UserModel.value.uid}");
    
  }

  @override
  Widget build(BuildContext context) {
    
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 252, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(userController.UserModel.value.totalRestaurants == 0)
                
              
              Container(
                width: width,
                height: height * 0.08,
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: FlutterSwitch(
                        width: 100.0,
                        height: 50.0,
                        valueFontSize: 18.0,
                        toggleSize: 35.0,
                        value: toggle,
                        borderRadius: 30.0,
                        activeColor: Color.fromARGB(255, 80, 233, 85),
                        padding: 5.0,
                        showOnOff: true,
                        onToggle: (val) {
                        setState(() {
                          toggle = val;
                        });
                      },
                      ),
                    ),
                     Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: InkWell(
                        onTap: (){
                          authController.logOut();
                        },
                        child: Text("Logout",style: TextStyle(fontSize: 18),),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              
            ],
          ),
        ),
      ),
    );
  }


  void checkTotalRestaurants() async{
    final ref = await FirebaseFirestore.instance
      .collection('RestaurantOwner')
      .doc(userController.UserModel.value.uid)
      .collection('Restaurants').snapshots();


    if(ref.length.toString() == '0'){
      setState(() {
        userController.UserModel.value.totalRestaurants = 0;
      });
    }
  }
}