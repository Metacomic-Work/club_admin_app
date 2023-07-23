import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_admin/controllers/userController.dart';
import 'package:club_admin/models/restaurantModel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/authorised/home.dart';

class RestaurantController extends GetxController{

  Rx<RestaurantModel> restaurantModel = RestaurantModel().obs;
  UserController userController = Get.put(UserController());
  

  Future<void> registerRestaurant() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final restoID = FirebaseFirestore.instance
    .collection('RestaurantOwner')
    .doc(userController.UserModel.value.uid)
    .collection("Restaurants")
    .doc();
    restaurantModel.value.restoId = restoID.id;
    await prefs.setString('restoID', restaurantModel.value.restoId.toString());

    try{
      await restoID.set({
        "uid": restaurantModel.value.uid,
        "RestoId": restaurantModel.value.restoId,
        "RestaurantName": restaurantModel.value.restaurantName,
        "RestaurantLogo": restaurantModel.value.restaurantImage,
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
    Get.offAll(const Home());
  }




  void registerRestaurantDetails()async {
    final restoDetailId = FirebaseFirestore.instance
    .collection('RestaurantOwner')
    .doc(userController.UserModel.value.uid)
    .collection("RestaurantDetails")
    .doc(restaurantModel.value.restoId);


    try{
      await restoDetailId.set({
        "uid": restaurantModel.value.uid,
        "RestoId": restaurantModel.value.restoId,
        "RestaurantName": restaurantModel.value.restaurantName,
        "Phone": restaurantModel.value.phone,
        "Email": restaurantModel.value.email,
        "RestaurantLogo": restaurantModel.value.restaurantImage,
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
        child('restaurant_images')
        .child(uniqueName);

    try{
      await ref.putFile(File(file));
      restaurantModel.value.restaurantImage = await ref.getDownloadURL();
    }catch(e){
      print("Cannot Upload Image or Get link");
      print(e);
    }
    return url; 
  }


  Future getRestaurantData() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final ref = await FirebaseFirestore.instance
      .collection('RestaurantOwner')
      .doc(prefs.getString('uid'))
      .collection('Restaurants')
      .doc(prefs.getString('restoID')).get();
    
    Map<String,dynamic>? restoData = ref.data();
    restaurantModel.value.restaurantName = restoData?['RestaurantName'];
    restaurantModel.value.restaurantImage = restoData?['RestaurantLogo'];
    restaurantModel.value.type = restoData?['RestaurantType'];


  }
  

}