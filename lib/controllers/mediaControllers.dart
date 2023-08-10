import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_admin/controllers/userController.dart';
import 'package:club_admin/models/itemModel.dart';
import 'package:club_admin/models/restaurantModel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';


class MediaController extends GetxController{


  Rx<ItemModel> itemModel = ItemModel().obs;
  Rx<RestaurantModel> restaurantModel = RestaurantModel().obs;
  UserController userController =Get.put(UserController()); 
  Stream<QuerySnapshot<Map<String, dynamic>>>? restaurantImagesStream;
  
  

  Future<void> uploadBannerImage(file) async{
    String url = '';
    String uniqueName = DateTime.now().microsecondsSinceEpoch.toString();
    final ref = FirebaseStorage.instance
        .ref().
        child('banner_images')
        .child(uniqueName);

    try{
      await ref.putFile(File(file));
      restaurantModel.value.bannerPath = await ref.getDownloadURL();
    }catch(e){
      print("Cannot Upload Image or Get link");
      print(e);
    }
   
  }

  void addBanner() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String restoId = await prefs.getString('restoID').toString();
    final restaurantImageId = FirebaseFirestore.instance
      .collection('RestaurantOwner')
      .doc(userController.UserModel.value.uid)
      .collection('RestaurantDetails')
      .doc(restoId)
      .collection('banners')
      .doc();

      print(restoId);
      print(restaurantImageId.id);

    final bannerCollection = FirebaseFirestore.instance
      .collection('Restaurants')
      .doc(restoId)
      .collection('banners')
      .doc(restaurantImageId.id);
        
    final homeBannerCollection = FirebaseFirestore.instance
      .collection('banners')
      .doc(restaurantImageId.id);

    Map<String,dynamic> bannerData = ({
        "BannerImage":restaurantModel.value.bannerPath,
    });
    
    try{
      await restaurantImageId.set(bannerData);
      await bannerCollection.set(bannerData);
      await homeBannerCollection.set(bannerData);
    }catch(e){
      print("Item cannot upload");
      print(e);
    }
  }


  Future<dynamic> getRestaurantImagesStream() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    restaurantImagesStream = FirebaseFirestore.instance
      .collection('RestaurantOwner')
      .doc(prefs.getString('uid').toString())
      .collection('RestaurantDetails')
      .doc(prefs.getString('restoID'))
      .collection('images').snapshots();
  }


  Future<void> uploadRestaurantInteriorImage(file) async{
    String url = '';
    String uniqueName = DateTime.now().microsecondsSinceEpoch.toString();
    final ref = FirebaseStorage.instance
        .ref().
        child('Interior_images')
        .child(uniqueName);

    try{
      await ref.putFile(File(file));
      restaurantModel.value.bannerPath = await ref.getDownloadURL();
    }catch(e){
      print("Cannot Upload Image or Get link");
      print(e);
    }
   
  }

  void addRestaurantInteriorImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String restoId = prefs.getString('restoID').toString();
    final restaurantImageId = FirebaseFirestore.instance
      .collection('RestaurantOwner')
      .doc(userController.UserModel.value.uid)
      .collection('RestaurantDetails')
      .doc(restoId)
      .collection('images')
      .doc();

      print(restoId);
      print(restaurantImageId.id);

    final imagesCollection = FirebaseFirestore.instance
      .collection('Restaurants')
      .doc(restoId)
      .collection('images')
      .doc(restaurantImageId.id);
        

    Map<String,dynamic> imageData = ({
        "RestaurantInteriorImage":restaurantModel.value.bannerPath,
    });
    
    try{
      await restaurantImageId.set(imageData);
      await imagesCollection.set(imageData);
    }catch(e){
      print("Item cannot upload");
      print(e);
    }
  }




}


