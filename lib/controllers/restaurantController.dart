import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_admin/models/restaurantModel.dart';
import 'package:get/get.dart';

class RestaurantController extends GetxController{

  Rx<RestaurantModel> restaurantModel = RestaurantModel().obs;

  void ResgisterRestaurant() async{
    final restoId = FirebaseFirestore.instance.collection('Restaurants').doc();

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




  void RegisterRestaurantDetails()async {
    final restoDetailId = FirebaseFirestore.instance.collection('RestaurantDetails').doc();
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
 

}