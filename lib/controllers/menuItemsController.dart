import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_admin/controllers/restaurantController.dart';
import 'package:club_admin/controllers/userController.dart';
import 'package:club_admin/models/itemModel.dart';
import 'package:club_admin/models/restaurantModel.dart';
import 'package:club_admin/models/userModel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuItemController extends GetxController{
  Rx<ItemModel> itemModel = ItemModel().obs;
  Rx<RestaurantModel> restaurantModel = RestaurantModel().obs;

  final itemNameController = TextEditingController();
  final itemPriceController = TextEditingController();
  final itemTypeController = TextEditingController();
  final itemDesController = TextEditingController();

  
  UserController userController = Get.put(UserController());
  Stream<QuerySnapshot<Map<String, dynamic>>>? menuItemStream;
  

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

    final itemCollection = FirebaseFirestore.instance
      .collection('Restaurants')
      .doc(restoId)
      .collection('menu')
      .doc();

    itemModel.value.itemId = itemCollection.id;    
    Map<String,dynamic> itemData = ({
        "ItemId": itemModel.value.itemId,
        "ItemName":itemModel.value.itemName,
        "ItemPrice":itemModel.value.price,
        "ItemDescription":itemModel.value.description,
        "ItemType":itemModel.value.itemType,
        "ItemImage":itemModel.value.itemImage,
    });
    
    try{
      await itemId.add(itemData);
      await itemCollection.set(itemData);
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

  Future<dynamic> getMenuItemStream() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    menuItemStream = FirebaseFirestore.instance
      .collection('RestaurantOwner')
      .doc(prefs.getString('uid').toString())
      .collection('RestaurantDetails')
      .doc(prefs.getString('restoID'))
      .collection('menu').orderBy("ItemPrice",descending:false ).snapshots();
  }
}
  
  
  

