import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_admin/controllers/mediaControllers.dart';
import 'package:club_admin/controllers/restaurantController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

class AddImages extends StatefulWidget {
  const AddImages({super.key});

  @override
  State<AddImages> createState() => _AddImagesState();
}

class _AddImagesState extends State<AddImages> {
  MediaController mediaController = Get.put(MediaController());
  RestaurantController restaurantController = Get.put(RestaurantController());

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
            child: Container(
              width: w * 0.95,
              height: h * 0.08,
              decoration:const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Color.fromARGB(255, 34, 34, 34)
              ),
              child:const Center(child: Text("Add Image",style: TextStyle(fontFamily: 'sen',color: Colors.white,fontSize: 20),)),
            ),
            onTap: () async {
              await showModalBottomSheet(
                context: context,
                builder: (context){
                  return StatefulBuilder(
                    builder: (context, setState){
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: h * 0.5,
                          child: Column(
                            children: [
                              if(restaurantController.restaurantModel.value.internalRestaurantImage != null)
                              Container(
                                  alignment: Alignment.center,
                                  width: w * 0.9,
                                  height: h * 0.2,
                                  decoration: BoxDecoration(
                                    borderRadius:const BorderRadius.all(Radius.circular(10)),
                                    image: DecorationImage(
                                      image: FileImage(File(restaurantController.restaurantModel.value.internalRestaurantImage!)),
                                      fit: BoxFit.cover,
                                    )
                                  ),
                                )
                              else
                              InkWell(
                                child: Container(
                                  alignment: Alignment.center,
                                  width: w * 0.9,
                                  height: h * 0.2,
                                  decoration:const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: Colors.grey
                                  ),
                                  child:const Center(child: Icon(Icons.image)),
                                ),
                                onTap: (){
                                  getImage(source: ImageSource.gallery);
                                },
                              ),
                              SizedBox(height: 30,),
                              GestureDetector(
                                child: Container(
                                  width: w * 0.95,
                                  height: h * 0.08,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: Colors.black,
                                  ),
                                  child: Center(
                                    child: Text("Upload",style: TextStyle(fontFamily: 'sen',fontSize: 14,color: Colors.white),),
                                  ),
                                ),
                                onTap: () async {
                                  await mediaController.uploadRestaurantInteriorImage(restaurantController.restaurantModel.value.internalRestaurantImage);
                                },
                              )
                            ],
                          ),
                        ),
          
                      );
                    }
                  );
                }
              );
      
            },
          ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              SizedBox(
                width: w * 0.95,
                height: h * 0.08,
                child: Row(
                  children: [
                    IconButton(onPressed: (){}, icon:const Icon(Icons.arrow_back_ios_new_rounded)),
                    const SizedBox(width: 10,),
                    const Text("Add Restaurant Images",style: TextStyle(fontFamily: 'sen',fontSize: 20),)
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              StreamBuilder(
                stream: mediaController.restaurantImagesStream,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if (snapshot.hasError) {
                    return Text("Something Wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return Text("No Images to Show");
                  }
                  if(snapshot.data != null){
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 150,
                        childAspectRatio: 1,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                      ),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context,index){
                        return Container(
                          width: w * 0.2,
                          height: w * 0.2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(snapshot.data!.docs[index]['RestaurantImage']),
                              fit: BoxFit.cover,
                            )
                          ),
                        );
                      },
                    );
                  }
                  return Container();
                },
                
              )
              
            ]
          )
        )
      ),
    );
  }

  void getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source);

    if (file?.path != null) {
      setState(() {
        restaurantController.restaurantModel.value.internalRestaurantImage = file!.path;
      });
    }
  }
}