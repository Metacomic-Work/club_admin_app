import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_admin/controllers/restaurantController.dart';
import 'package:club_admin/controllers/userController.dart';
import 'package:club_admin/models/itemModel.dart';
import 'package:club_admin/models/restaurantModel.dart';
import 'package:club_admin/models/userModel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuItemController extends GetxController{
  Rx<ItemModel> itemModel = ItemModel().obs;
  Rx<RestaurantModel> restaurantModel = RestaurantModel().obs;
  UserController userController = Get.put(UserController());
  


  void addItem() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String restoId = await prefs.getString('restoID').toString();
    final itemId = FirebaseFirestore.instance
      .collection('RestaurantOwner')
      .doc(userController.UserModel.value.uid)
      .collection('RestaurantDetails')
      .doc(restoId)
      .collection('menu');
      print(restoId);
    
    try{
      await itemId.add({
        "ItemName":itemModel.value.itemName,
        "ItemPrice":itemModel.value.price,
        "ItemDescription":itemModel.value.description,
        "ItemType":itemModel.value.itemType,
        "ItemImage":itemModel.value.itemImage,
      });
    }catch(e){
      print("Item cannot upload");
      print(e);
    }

  }






  Future<void> uploadItemImage(file) async{
    String url = '';
    String uniqueName = DateTime.now().microsecondsSinceEpoch.toString();
    final ref = FirebaseStorage.instance
        .ref().
        child('menu_item_images')
        .child(uniqueName);

    try{
      await ref.putFile(File(file));
      itemModel.value.itemImage = await ref.getDownloadURL();
    }catch(e){
      print("Cannot Upload Image or Get link");
      print(e);
    } 

  }
}
  
  

