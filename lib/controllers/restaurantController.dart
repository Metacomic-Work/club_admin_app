import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_admin/models/restaurantModel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class RestaurantController extends GetxController{

  Rx<RestaurantModel> restaurantModel = RestaurantModel().obs;
  var uid;
  void registerRestaurant() async{
    final restoId = FirebaseFirestore.instance
    .collection('RestaurantOwners')
    .doc(uid)
    .collection("Restaurants")
    .doc();

    try{
      await restoId.set({
        "uid": restaurantModel.value.uid,
        "RestoId": restaurantModel.value.restoId,
        "RestaurantName": restaurantModel.value.restaurantName,
        "RestaurantLogo": restaurantModel.value.logo,
        "StartTime" : restaurantModel.value.startTime,
        "EndTime": restaurantModel.value.endTime,
        "Area":restaurantModel.value.area,
        "RestaurantType":restaurantModel.value.type,
        "isAvailable": restaurantModel.value.isAvailable,
      });
    }catch(e){
      print("Registration Unsuccessful\n");
      print(e);
    }
  }




  void registerRestaurantDetails()async {
    final restoDetailId = FirebaseFirestore.instance
    .collection('RestaurantOwners')
    .doc(uid)
    .collection("RestaurantDetails")
    .doc();


    try{
      await restoDetailId.set({
        "uid": restaurantModel.value.uid,
        "RestoId": restaurantModel.value.restoId,
        "RestaurantName": restaurantModel.value.restaurantName,
        "Phone": restaurantModel.value.phone,
        "Email": restaurantModel.value.email,
        "RestaurantLogo": restaurantModel.value.logo,
        "StartTime" : restaurantModel.value.startTime,
        "EndTime": restaurantModel.value.endTime,
        "Area":restaurantModel.value.area,
        "Landmark":restaurantModel.value.landmark,
        "City": restaurantModel.value.city,
        "Pincode": restaurantModel.value.pincode,
        "Latitude":restaurantModel.value.latitude,
        "Longitude": restaurantModel.value.longitude,
        "RestaurantType":restaurantModel.value.type,
        "isAvailable": restaurantModel.value.isAvailable,
    });
    }catch(e){
      print("Cannot Update Restaurant Details\n");
      print(e);
    }
  }
 
  Future<String> uploadRestaurantImage(file) async {
    String url = '';
    String uniqueName = DateTime.now().microsecondsSinceEpoch.toString();
    final ref = FirebaseStorage.instance
        .ref().
        child('Restaurant_images')
        .child(uniqueName);

    try{
      await ref.putFile(File(file));
      url = await ref.getDownloadURL();
    }catch(e){
      print("Cannot Upload Image or Get link");
      print(e);
    }
    return url; 
  }
  

}