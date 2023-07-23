import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/userModel.dart';

class HomeController extends GetxController{

  Rx<userModel> UserModel = userModel().obs;

  void checkTotalRestaurants() async{
    final ref = await FirebaseFirestore.instance
      .collection('RestaurantOwner')
      .doc(UserModel.value.uid)
      .collection('Restaurants').snapshots();


    if(ref.length.toString() == '0'){
      
    }
  }


}