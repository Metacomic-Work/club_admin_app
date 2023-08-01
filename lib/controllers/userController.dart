
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/userModel.dart';
import '../views/authorised/Home.dart';

class UserController extends GetxController{
  Rx<userModel> UserModel = userModel().obs;


  void registerUser() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    UserModel.value.token =await prefs.getString('token');
    
      final UserId = FirebaseFirestore.instance.collection('users').doc(UserModel.value.uid);
      try{
        await UserId.set({
          "uid":UserModel.value.uid,
          "token": UserModel.value.token,
          "UserName":UserModel.value.name,
          "Gender":UserModel.value.gender,
          "Phone":UserModel.value.phone,
          "DOB":UserModel.value.dob,
          "ProfileImage":UserModel.value.profileImage,
          "isOwner":UserModel.value.isOwner,
          "isDJ":UserModel.value.isDj,
          }
        );
      }catch(e){
        print(e.toString());
        print("Unable to register user");
      }
  }

  void registerOwner() async{
      final UserId = FirebaseFirestore.instance
        .collection('RestaurantOwner')
        .doc(UserModel.value.uid);

      
      try{
        await UserId.set({
          "uid":UserModel.value.uid,
          "token": UserModel.value.token,
          "UserName":UserModel.value.name,
          "Gender":UserModel.value.gender,
          "Phone":UserModel.value.phone,
          "DOB":UserModel.value.dob,
          "ProfileImage":UserModel.value.profileImage,
          "isOwner":UserModel.value.isOwner,
          "isDJ":UserModel.value.isDj,
          }
        );
      }catch(e){
        print(e.toString());
        print("Unable to register user");
      }
  }


  Future<String> uploadProfileImage(file) async {
    String url = '';
    String uniqueName = DateTime.now().microsecondsSinceEpoch.toString();
    final ref = FirebaseStorage.instance
        .ref().
        child('profile_images')
        .child(uniqueName);

    try{
      await ref.putFile(File(file));
      UserModel.value.profileImage = await ref.getDownloadURL();
    }catch(e){
      print("Cannot Upload Image or Get link");
      print(e);
    }
    return url; 
  }

  Future selectRestaurant(restoId)async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('restoID', restoId);
    Get.to(Home());
  }
}