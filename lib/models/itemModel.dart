
import 'dart:convert';
import 'dart:io';

ItemModel userFromJson(String str) => ItemModel.fromJson(json.decode(str));

//String userToJson(ItemModel data) => json.encode(data.toJson());

class ItemModel{
    String? uid;
    String? itemName;
    String? description;
    String? price;
    String? itemType;
    int? serving;
    int? discount;
    File? itemImage;
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
        this.recomended,
        this.isAvailable,
  
    });

    factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        uid: json["uid"],
        
    );

    
}
