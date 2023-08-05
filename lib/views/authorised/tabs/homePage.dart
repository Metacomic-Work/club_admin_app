import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_admin/controllers/authController.dart';
import 'package:club_admin/controllers/homeController.dart';
import 'package:club_admin/controllers/userController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

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
                        activeColor:const Color.fromARGB(255, 80, 233, 85),
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
                        child:const Text("Logout",style: TextStyle(fontSize: 18),),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                width: width,
                height: height * 0.8,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('RestaurantOwner').doc(homeController.restaurantModel.value.uid).collection('RestaurantDetails').doc(homeController.restaurantModel.value.restoId).collection('bookings').snapshots(),
                    builder: (context, snapshot){
                      if(snapshot.hasError){
                        return const Text("Something is Wrong");
                      }
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if(snapshot.data!.docs.isEmpty){
                        return const Center(child:Text("No Bookings",style: TextStyle(fontSize: 20,fontFamily: 'sen'),));
                      }
                      if(snapshot.data !=null){
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context,index){
                            return Container(
                              width: width,
                              height: height * 0.2,
                              margin:const EdgeInsets.symmetric(vertical: 10),
                              decoration:const BoxDecoration(
                                color: Colors.white
                              ), 
                              child: Padding(
                                padding:  EdgeInsets.all(18.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Guest Name: ${snapshot.data!.docs[index]['GuestName']}",style:const TextStyle(fontFamily:'sen',fontSize: 18),),
                                    const SizedBox(height: 12,),
                                    Text("Phone: ${snapshot.data!.docs[index]['Phone']}",style:const TextStyle(fontSize: 15,fontFamily: 'sen')),
                                    const SizedBox(height: 12,),
                                    Text("Date: ${snapshot.data!.docs[index]['Date']}",style:const TextStyle(fontSize: 15,fontFamily: 'sen')),
                                    const SizedBox(height: 12,),
                                    Text("Time: ${snapshot.data!.docs[index]['Time']}",style:const TextStyle(fontSize: 15,fontFamily: 'sen'))
                                  ],
                                )
                              ),
                            );
                          },
                        );
                      }
                      return Container();
                    },
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}