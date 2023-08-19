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
  List<File> media = [];
  List<String> imagePaths = [];


  Rx<ItemModel> itemModel = ItemModel().obs;
  Rx<RestaurantModel> restaurantModel = RestaurantModel().obs;
  UserController userController =Get.put(UserController()); 
  Stream<DocumentSnapshot<Object?>>? restaurantImagesStream;
  
  

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
    FirebaseFirestore.instance
        .collection("Restaurants")
        .doc(prefs.getString('restoID'))
        .collection('images')
        .doc('I${prefs.getString('restoID')}').snapshots();
  }

  
    List<dynamic> allData =[];
    Future<QuerySnapshot?> getData() async {
      
        dynamic dataofItem = FirebaseFirestore.instance
            .collection('')
            .get()
            .then((QuerySnapshot? querySnapshot) {
          querySnapshot!.docs.forEach((doc) {
            allData = doc["item_text_"];
            print("allData = $allData");
            //  print("getData = ${doc["item_text_"]}");
          });
        });
        return dataofItem;
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





  Future<void> uploadRestaurantInternalImages() async {
    String uniqueName = DateTime.now().microsecondsSinceEpoch.toString();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String restoId = prefs.getString('restoID').toString();
    try {

      //uploading images
      List<String> imageUrls = [];
      for (File image in media) {
        final Reference storageReference =  FirebaseStorage.instance
        .ref()
        .child('Interior_images')
        .child(uniqueName);
        final UploadTask uploadTask = storageReference.putFile(image);
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
        if (taskSnapshot.state == TaskState.success) {
          final downloadURL = await taskSnapshot.ref.getDownloadURL();
          imageUrls.add(downloadURL);
          print(downloadURL);
        }
      }
      //uploading post to firestore

      final ref = await FirebaseFirestore.instance
        .collection("Restaurants")
        .doc(restoId)
        .collection("images")
        .doc('I$restoId').update({
          "Images": imageUrls
        }
      );

      await prefs.setString("imagesID",'I$restoId');
      
    } catch (e) {
      print(e);
    }
  }
}

