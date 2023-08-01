
import 'dart:convert';
import 'dart:io';

userModel userFromJson(String str) => userModel.fromJson(json.decode(str));

//String userToJson(userModel data) => json.encode(data.toJson());

class userModel{
    String? uid;
    String? token;
    String? name;
    String? phone;
    String? email;
    String? gender;
    dynamic dob;
    String? imagePath;
    String? profileImage;
    String? location;
    int? totalRestaurants;
    String? selectedRestaurant;
    bool? isDj;
    bool? isOwner;

    userModel({
        this.uid,
        this.token,
        this.name,
        this.phone,
        this.email,
        this.imagePath,
        this.gender,
        this.dob,
        this.profileImage,
        this.location,
        this.selectedRestaurant,
        this.totalRestaurants = 0,
        this.isDj = false,
        this.isOwner = true,
  
    });

    factory userModel.fromJson(Map<String, dynamic> json) => userModel(
        uid: json["uid"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        gender: json["gender"],
        profileImage: json["profileImage"],
        location: json["location"],
    );

    /*Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "phone": phone,
        "email": email,
        "gender": gender,
        "profile": profile,
        "location": location,
        "membership": membership,
        "table_bookings": List<dynamic>.from(tableBookings.map((x) => x)),
        "total_booking": totalBooking,
        "reward_points": rewardPoints,
        "liked_restos": List<dynamic>.from(likedRestos.map((x) => x)),
        "transactions": List<dynamic>.from(transactions.map((x) => x)),
    };*/
}
