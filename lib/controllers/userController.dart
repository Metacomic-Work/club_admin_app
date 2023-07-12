import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';

import '../models/userModel.dart';

class UserController extends GetxController{
  Rx<userModel> UserModel = userModel().obs;


  void registerUser() async{
      final UserId = FirebaseFirestore.instance.collection('users').doc(UserModel.value.uid);
      try{
        await UserId.set({
          "uid":UserModel.value.uid,
          "UserName":UserModel.value.name,
          "Gender":UserModel.value.gender,
          "Phone":UserModel.value.phone,
          "DOB":UserModel.value.dob,
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
      final UserId = FirebaseFirestore.instance.collection('RestaurantOwner').doc(UserModel.value.uid);
      try{
        await UserId.set({
          "uid":UserModel.value.uid,
          "UserName":UserModel.value.name,
          "Gender":UserModel.value.gender,
          "Phone":UserModel.value.phone,
          "DOB":UserModel.value.dob,
          "isOwner":UserModel.value.isOwner,
          "isDJ":UserModel.value.isDj,
          }
        );
      }catch(e){
        print(e.toString());
        print("Unable to register user");
      }
  }
}