import 'package:club_admin/controllers/restaurantController.dart';
import 'package:club_admin/views/authorised/addItem.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  RestaurantController restaurantController = Get.put(RestaurantController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    restaurantController.getRestaurantData();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          child: Container(
            width: width * 0.9,
            height: height * 0.05,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color.fromARGB(255, 64, 86, 244),
            ),
            child: Center(child: Text("Add Item",style: TextStyle(fontFamily: 'sen',fontSize: 20,color: Colors.white),)),
          ),
          onTap: (){
            Get.to(AddItem());
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child:Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Container(
                      width: width * 0.28,
                      height: height * 0.12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        image: DecorationImage(
                          image: NetworkImage(restaurantController.restaurantModel.value.restaurantImage.toString()),
                          fit: BoxFit.cover,
                        )                        
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Container(
                      width: width * 0.5,
                      height: height * 0.12,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(restaurantController.restaurantModel.value.restaurantName.toString(),style: TextStyle(fontFamily: 'sen',fontSize: 22,color: Colors.black),),
                          SizedBox(height: 5,),
                          Text(restaurantController.restaurantModel.value.type.toString(),style: TextStyle(fontFamily: 'sen',fontSize: 12,color: Colors.grey),),
                        ],
                      ),

                    )
                  ],
                ),
              ),
              Container(
                height: height * 0.6,
                width: width,
              )
            ],
          )
        ),
      ),
    );
  }
}