
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';

ItemModel userFromJson(String str) => ItemModel.fromJson(json.decode(str));

//String userToJson(ItemModel data) => json.encode(data.toJson());

class ItemModel extends GetxController{
    String? uid;
    String? itemName;
    String? description;
    String? price;
    String? itemType = 'veg';
    int? serving;
    int? discount;
    String? itemImage;
    String? imagePath;
    bool? recomended;
    bool? isAvailable;
    bool? isSpecial;

    ItemModel({
        this.uid,
        this.description,
        this.price,
        this.itemType,
        this.serving,
        this.discount,
        this.isSpecial,
        this.itemImage,
        this.itemName,
        this.imagePath,
        this.recomended,
        this.isAvailable,
  
    });

    factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        uid: json["uid"],
        
    );

    
}
