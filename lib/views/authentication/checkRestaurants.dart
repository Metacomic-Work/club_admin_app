import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_admin/controllers/restaurantController.dart';
import 'package:club_admin/controllers/userController.dart';
import 'package:club_admin/views/authorised/registerResto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../authorised/Home.dart';

class CheckRestaurants extends StatelessWidget {
  const CheckRestaurants({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    UserController userController = Get.put(UserController());
    return Scaffold(
      bottomNavigationBar: InkWell(
        child: Container(
          width: w,
          height: h * 0.06,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.blue,
          ),
          child: Center(child: Text("Add Restaurant",style: TextStyle(fontFamily: 'sen',fontSize: 18,color: Colors.white),)),
        ),
        onTap: (){
          Get.to(RegisterRestaurant());
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Registered Restaurants",style: TextStyle(fontSize: 25,fontFamily: 'sen',fontWeight: FontWeight.bold),),
              SizedBox(height: 15,),
              Container(
                width: w* 0.95,
                height: h * 0.8,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('RestaurantOwner').doc(userController.UserModel.value.uid).collection('Restaurants').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                    if(snapshot.hasError){
                        return const Text("Something is Wrong");
                      }
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if(snapshot.data!.docs.isEmpty){
                        return const Center(child:Text("No Restaurants to show",style: TextStyle(fontSize: 20,fontFamily: 'sen'),));
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context,index){
                          return InkWell(
                            child: Container(
                              height: 170,
                              margin: const EdgeInsets.only(top: 8, bottom: 8),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(color: const Color.fromARGB(255, 237, 237, 237),style: BorderStyle.solid,width: 1),
                                color: const Color.fromARGB(255, 244, 244, 244),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.1),blurRadius: 30,offset: const Offset(0, 10),
                                    )
                                  ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Row(
                                      children: [
                                        Stack(
                                          children: <Widget>[
                                            Container(
                                              width: 110,
                                              decoration: BoxDecoration(
                                                borderRadius:const BorderRadius.all(Radius.circular(10)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black.withOpacity(.1),
                                                    blurRadius: 30,
                                                    offset: const Offset(0, 5),
                                                  )
                                                ],
                                                image: DecorationImage(
                                                  image: NetworkImage(snapshot.data!.docs[index]['RestaurantLogo']??""),
                                                  fit: BoxFit.cover)),
                                                ),
                                                Container(
                                                  width: 110,
                                                  decoration: BoxDecoration(
                                                    borderRadius:const BorderRadius.all(Radius.circular(10)),
                                                    gradient: LinearGradient(
                                                      begin: FractionalOffset.topCenter,
                                                      end: FractionalOffset.bottomCenter,
                                                      colors: [
                                                      const Color.fromARGB(255, 210, 210, 210).withOpacity(0.0),
                                                      const Color.fromARGB(166, 31, 31, 31),
                                                      ],
                                                      stops:const [
                                                        0.0,1.0
                                                      ])
                                                    ),
                                                  ),
                  Positioned(
                    bottom: 14,
                    child: offer(index),
                  ),
                ],
              ),
              const SizedBox(
                width: 15,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      snapshot.data!.docs[index]['RestaurantName'],
                      
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Rating(index),
                    SizedBox(
                      height: 5,
                    ),
                    RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          text: snapshot.data!.docs[index]['RestaurantType'],
                        )),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: Container(
                        height: .5,
                        width: 180,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 25,
                child: Stack(
                  children: [
                    
                  ],
                ),
              )
            ],
          )),
    ),
    onTap: () async {
      userController.UserModel.value.selectedRestaurant =await snapshot.data!.docs[index]['RestoId'];
      await userController.selectRestaurant(userController.UserModel.value.selectedRestaurant);
    },
  );
                        },
                      );
                  },
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}

Widget offer(index) {
  return Container(
    height: 20,
    width: 60,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(10), topRight: Radius.circular(10)),
      color: Color.fromARGB(255, 0, 140, 255),
    ),
    child: Center(
      child: Text(
        "50% off",
      ),
    ),
  );
}

Widget Rating(index) {
  return Container(
    height: 20,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      color: Color.fromARGB(255, 56, 165, 60),
    ),
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Center(
        child: Row(
          children: [
            Text(
              " 4.2",
              
            ),
            const SizedBox(
              width: 5,
            ),
            const Icon(
              Icons.star_rounded,
              color: Colors.white,
              size: 14,
            )
          ],
        ),
      ),
    ),
  );
}
