import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_admin/controllers/restaurantController.dart';
import 'package:club_admin/models/couponModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfferController extends GetxController{

  TextEditingController heading = TextEditingController();
  TextEditingController offer = TextEditingController();
  TextEditingController code = TextEditingController();

  RestaurantController restaurantController = RestaurantController();
  final fire = FirebaseFirestore.instance;
  Rx<CoupounModel> coupounModel = CoupounModel().obs;


  bool formValidator(){
    if(heading.text.isNotEmpty && code.text.isNotEmpty && offer.text.isNotEmpty){
      return true;
    }else{
      return false;
    }
    
  }

  Future<void> addOffer() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    coupounModel.value.heading = heading.text.toString();
    coupounModel.value.code = code.text.toString();
    coupounModel.value.offer = int.parse(offer.text);

    final ownerRef = fire
      .collection('RestaurantOwner')
      .doc(prefs.getString('uid'))
      .collection('RestaurantDetails')
      .doc(prefs.getString('restoID'))
      .collection('offers').doc(coupounModel.value.code);

    final restaurantRef = fire
      .collection('Restaurants')
      .doc(prefs.getString('restoID'))
      .collection('offers')
      .doc(coupounModel.value.code);

    final data = {
      "Heading":coupounModel.value.heading,
      "Offer": coupounModel.value.offer,
      "MaxOffer": coupounModel.value.maxOffer,
      "Code": coupounModel.value.code,
    };

    await ownerRef.set(data);
    await restaurantRef.set(data);
    
  }


}