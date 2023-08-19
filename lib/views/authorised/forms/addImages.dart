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
  List<Map<String,dynamic>> media = [];
  MediaController mediaController = Get.put(MediaController());
  RestaurantController restaurantController = Get.put(RestaurantController());
  bool isLoading = false;

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
                              SizedBox(height: 10,),
                              Container(
                                  alignment: Alignment.center,
                                  width: w * 0.9,
                                  height: h * 0.2,
                                  decoration: BoxDecoration(
                                    borderRadius:const BorderRadius.all(Radius.circular(10)),
                                    color: Color.fromARGB(255, 236, 250, 255)
                                  ),
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: mediaController.media.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          child: Image.file(mediaController.media[index],fit: BoxFit.cover),
                                        ),
                                      );
                                    }
                                  )
                                ),
                                TextButton(
                                  onPressed: () async{
                                    
                                    getImage(source: ImageSource.gallery);
                                  }, 
                                child: Text("Pick Images",style:TextStyle(fontFamily: 'sen',fontSize: 20,))
                              ),
                              SizedBox(height: h * 0.14,),
                              GestureDetector(
                                child: Container(
                                  width: w * 0.95,
                                  height: h * 0.08,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: Colors.black,
                                  ),
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Text("Upload",style: TextStyle(fontFamily: 'sen',fontSize: 14,color: Colors.white),),
                                        if(isLoading == false)
                                        Container()
                                        else 
                                        CircularProgressIndicator(),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () async {
                                  upload();
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
              StreamBuilder<DocumentSnapshot>(
                stream:mediaController.restaurantImagesStream,
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
                  if (snapshot.hasError) {
                    return Text("Something Wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }
                  if (snapshot.data!.data() == null) {
                    return const Text("No Images to Show");
                  }

                 //final List<dynamic> data = snapshot.data?['Images'];

                 //print(data);

                  if(snapshot.data != null){
                    Map<String,dynamic> data = snapshot.data!.data()! as Map<String,dynamic>;
                    return GridView(
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 150,
                        childAspectRatio: 1,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                      ),
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
    final images = await ImagePicker().pickMultiImage();

    for(var i=0;i < images.length;i++){
      File file = File(images[i].path);
      setState(() {
        mediaController.media.add(file);
      });
    }
  }

  Future<void> upload() async{
    setState(() {
      isLoading = true;
    });
    mediaController.uploadRestaurantInternalImages();
    setState(() {
      isLoading = false;
    });
  }
  
}