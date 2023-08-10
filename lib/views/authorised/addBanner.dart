import 'dart:io';

import 'package:club_admin/controllers/restaurantController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../../controllers/mediaControllers.dart';

class AddBanner extends StatefulWidget {
  const AddBanner({super.key});

  @override
  State<AddBanner> createState() => _AddBannerState();
}

class _AddBannerState extends State<AddBanner> {
  RestaurantController restaurantController = Get.put(RestaurantController());
  MediaController mediaController = Get.put(MediaController());
  
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        child: Container(
          width: w * 0.95,
          height: h * 0.08,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color.fromARGB(255, 30, 30, 30),
          ),
          child: Center(
            child: Text("Add Banner",style: TextStyle(fontFamily: 'sen',color: Colors.white,fontSize: 20),),
          ),
        ),
        onTap: () async{
          await mediaController.uploadBannerImage(restaurantController.restaurantModel.value.banner);
          mediaController.addBanner();
          var snackBar =const SnackBar(content: Text("Banner Added Successfully"),backgroundColor: const Color.fromARGB(255, 106, 203, 109),);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          

        },
      ),
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              
              Container(
                width: w * 0.95,
                height: h * 0.08,
                child: Row(
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios_new_rounded)),
                    SizedBox(width: 10,),
                    Text("Add Banner",style: TextStyle(fontFamily: 'sen',fontSize: 20),)
                  ],
                ),
              ),
              if(restaurantController.restaurantModel.value.banner != null)
              Container(
                width: w * 0.95,
                height: h * 0.2,
                decoration: BoxDecoration(
                  borderRadius:const BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                    image: FileImage(File(restaurantController.restaurantModel.value.banner!)),
                    fit: BoxFit.cover,
                  )
                ),
              )
              else
              GestureDetector(
                child: Container(
                  width: w * 0.95,
                  height: h * 0.2,
                  decoration:const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color.fromARGB(255, 197, 197, 197),
                  ),
                  child:const Center(
                    child: Icon(Icons.add),
                  ),
                ),
                onTap: (){
                  getImage(source: ImageSource.gallery);
                },
              )
            ],
          ),
        ),
      ) ,
    );
  }

  void getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source);

    if (file?.path != null) {
      setState(() {
        restaurantController.restaurantModel.value.banner = file!.path;
      });
    }
  }
  
}
