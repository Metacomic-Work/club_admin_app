
import 'dart:convert';
import 'dart:io';

RestaurantModel userFromJson(String str) => RestaurantModel.fromJson(json.decode(str));
//String userToJson(RestaurantModel data) => json.encode(data.toJson());

class RestaurantModel{

    String? uid; // admin uid
    String? restoId; // current doc uid
    String? restaurantName;
    String? phone;
    String? email;
    File? logo;
    String? startTime;
    String? endTime;
    String? area;
    String? landmark;
    int? pincode;
    String? city;
    String? latitude;
    String? longitude;
    String? type;
    bool? isAvailable;
    bool? isOwnew;

    RestaurantModel({
        this.uid,
        this.restoId,
        this.restaurantName,
        this.phone,
        this.email,
        this.logo,
        this.startTime,
        this.endTime,
        this.area,
        this.landmark,
        this.pincode,
        this.latitude,
        this.longitude,
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
