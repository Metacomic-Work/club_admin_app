
import 'dart:convert';
import 'dart:io';
import 'package:geolocator/geolocator.dart';

RestaurantModel userFromJson(String str) => RestaurantModel.fromJson(json.decode(str));
 
class RestaurantModel{

    String? uid;  
    String? restoId;  
    String? token;
    String? restaurantName;
    String? phone;
    String? email;
    String? imagePath;
    String? restaurantImage;
    String? startTime;
    String? endTime;
    String? area;
    String? landmark;
    String? pincode;
    String? city;
    String? latitude;
    String? longitude;
    String? address;
    String? currentAddress;
    Position? position;
    String? type;
    bool? isAvailable;
    bool? isOwnew;
    String? banner;
    String? bannerPath;
    String? internalRestaurantImage;
    String? internalRestaurantImagePath;

    RestaurantModel({
        this.uid,
        this.restoId,
        this.token,
        this.restaurantName,
        this.phone,
        this.banner,
        this.bannerPath,
        this.email,
        this.imagePath,
        this.internalRestaurantImage,
        this.internalRestaurantImagePath,
        this.restaurantImage,
        this.startTime,
        this.endTime,
        this.area,
        this.landmark,
        this.pincode,
        this.latitude,
        this.longitude,
        this.address,
        this.currentAddress,
        this.position,
        this.city,
        this.type,
        this.isAvailable  = true,
        this.isOwnew = false,
    });

    

    factory RestaurantModel.fromJson(Map<String, dynamic> json) => RestaurantModel(
        uid: json["uid"],
        restaurantName: json["name"],
        phone: json["phone"],
        email: json["email"],
    );

      
}
