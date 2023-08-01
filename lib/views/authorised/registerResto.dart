import 'dart:io';
import 'package:club_admin/components/formComponents/formImage.dart';
import 'package:club_admin/controllers/restaurantController.dart';
import 'package:club_admin/services/notificationServices.dart';
import 'package:club_admin/views/authorised/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../components/formComponents/formDropdown.dart';
import '../../components/formComponents/formTextField.dart';
import '../../components/formComponents/startTimeEndTime.dart';


final restaurantName = TextEditingController();
final area = TextEditingController();
final landmark = TextEditingController();
final city = TextEditingController();
final pincode = TextEditingController();

// final startTime = TextEditingController();
// final endTime = TextEditingController();
GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();


@override
class RegisterRestaurant extends StatefulWidget {
  const RegisterRestaurant({Key? key}) : super(key: key);
  @override
  _RegisterRestaurantState createState() => _RegisterRestaurantState();
}

class _RegisterRestaurantState extends State<RegisterRestaurant> {
  
  RestaurantController restaurantController = Get.put(RestaurantController());
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationServices.getDeviceToken();
  }

  @override
  Widget build(BuildContext context) {
    dynamic height = MediaQuery.sizeOf(context).height;
    dynamic width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
            child: SizedBox(
              child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0, bottom: 25, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                          child: InkWell(
                              onTap: () {},
                              child:const Icon(Icons.arrow_back_ios_new_rounded))),
                      Center(
                        child: Text("Register Restaurant",style: TextStyle(color: Color.fromARGB(255, 48, 47, 47),fontFamily: 'sen',
                              fontSize: height * 0.029),
                        ),
                      ),
                      const Center(child: Icon(Icons.emoji_emotions)),
                    ],
                  ),
                ),
                FormImage(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          textField(
                              name: "userName",
                              controller: restaurantName,
                              label: "RestoName",
                              keybordtype: TextInputType.name),
                          FormDropdown(),
                          StartEndTime().startEndTime(context),
                          const Padding(
                            padding: EdgeInsets.only(top: 25),
                            child: Column(children: [
                              Divider(),
                              Text(
                                "Address",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'sen',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              Divider(),
                            ]),
                          ),
                            Container(
                              width: width * 0.9,
                              height: height * 0.06,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                border: Border.all(color:const Color.fromARGB(255, 27, 27, 27))
                              ),
                              child: Row(
                                children: [
                                  //if(restaurantController.restaurantModel.value.currentAddress != null)
                                  Obx( 
                                    ()=> Container(
                                      width: width *0.65,
                                      child:  Text(restaurantController.restaurantModel.value.currentAddress.toString(),style:const TextStyle(fontSize: 15,fontFamily: 'sen', overflow: TextOverflow.ellipsis,),maxLines: 1,)
                                      )
                                    ),
                                  InkWell(
                                    child: Text("Locate me",style: TextStyle(fontSize: 18,color: Colors.blue),),
                                    onTap: ()async {
                                      await restaurantController.getCurrentPosition();
                                    },
                                  )
                                ],
                              ),
                            ),
                          textField(
                              name: "area",
                              controller: area,
                              label: "Area",
                              keybordtype: TextInputType.multiline   
                          ),
                          textField(
                              name: "LandMark",
                              controller: landmark,
                              label: "LandMark",
                              keybordtype: TextInputType.multiline),
                          textField(
                              name: "City",
                              controller: city,
                              label: "City",
                              keybordtype: TextInputType.streetAddress),
                          textField(
                              name: "area pincode",
                              controller: pincode,
                              label: "Area Pincode",
                              keybordtype: TextInputType.number),
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 54, 54, 54)),
                                onPressed: () async {
                                  restaurantController.restaurantModel.value.restaurantName = restaurantName.text;
                                  restaurantController.restaurantModel.value.area = area.text;
                                  restaurantController.restaurantModel.value.landmark = landmark.text;
                                  restaurantController.restaurantModel.value.city = city.text;
                                  restaurantController.restaurantModel.value.pincode = pincode.text;
                                  await restaurantController.uploadRestaurantImage(restaurantController.restaurantModel.value.imagePath);
                                  await restaurantController.registerRestaurant();
                                  restaurantController.registerRestaurantDetails();
                                  
                                },
                                child: const Text(
                                  "Register Restaurant",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 197, 195, 195),
                                    fontFamily: 'sen',
                                    fontSize: 18,
                                  ),
                                )),
                          ),
                        ]),
                  ),
              ],
            )
          )
        ),
      ),
    );
  }
}
