import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_admin/controllers/restaurantController.dart';
import 'package:club_admin/models/restaurantModel.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/userModel.dart';

class HomeController extends GetxController{

  Rx<userModel> UserModel = userModel().obs;
  RestaurantController restaurantController = Get.put(RestaurantController());
  Rx<RestaurantModel> restaurantModel = RestaurantModel().obs;

  Stream<QuerySnapshot<Map<String, dynamic>>>? bookingStream;

  void checkTotalRestaurants() async{
    final ref = await FirebaseFirestore.instance
      .collection('RestaurantOwner')
      .doc(UserModel.value.uid)
      .collection('Restaurants').snapshots();


    if(ref.length.toString() == '0'){
      
    }
  }

    Future<void> getBookings()async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    restaurantModel.value.uid = prefs.getString('uid');
    restaurantModel.value.restoId = prefs.getString('restoID');

    bookingStream = await FirebaseFirestore.instance
      .collection('RestaurantOwner')
      .doc(prefs.getString('uid'))
      .collection('RestaurantDetails')
      .doc(prefs.getString('restoID'))
      .collection('bookings').snapshots();
  }


}