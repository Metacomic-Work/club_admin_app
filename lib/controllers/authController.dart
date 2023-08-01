
import "package:cloud_firestore/cloud_firestore.dart";
import "package:club_admin/controllers/userController.dart";
import "package:club_admin/views/authentication/checkRestaurants.dart";
import "package:club_admin/views/authentication/register.dart";
import "package:club_admin/views/authorised/registerResto.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../views/authentication/login.dart";






class AuthController extends GetxController{
  final auth = FirebaseAuth.instance;
  TextEditingController textEditingController = TextEditingController();
  var verificationID = ''.obs;
  var code = ''.obs;
  UserController userController = Get.put(UserController());


  @override
  void onInit() async{
    super.onInit();
    
  }

  @override
  void onReady() async{
    super.onReady();
  }


  @override
  void onClose(){
    super.onClose();
    textEditingController.dispose();
    
  }


  Future getUserId() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final FirebaseAuth CurrentUser = FirebaseAuth.instance;
    final User? user = CurrentUser.currentUser;
    final uid = user?.uid;
    userController.UserModel.value.uid = uid;
    await prefs.setString('uid',uid.toString());
    print("Current user UID$uid");
  }


  Future<void> phoneVerification(String phoneNo) async{
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (e){
        if(e.code == 'invalid-phone-number'){
          Get.snackbar('Error', 'The Given Phone Number is Invalid');
        }else{
          Get.snackbar('Error', 'Something went Wrong, Try Again');
        }
      },
      codeSent: (verificationID,resendToken){
        this.verificationID.value = verificationID;
      },
      codeAutoRetrievalTimeout: (verificationID){
        this.verificationID.value = verificationID;
      }
    );
  }


  Future<bool>  verifyOtp(String otp)async {
    var credentials = await auth.signInWithCredential(
      PhoneAuthProvider.credential(verificationId:
       this.verificationID.value,
      smsCode: otp)
    );
    return credentials.user != null ? true : false;
  }
  

  Future<bool> checkRestaurants() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    QuerySnapshot<Map<String, dynamic>> query = await FirebaseFirestore.instance
      .collection('RestaurantOwner')
      .doc(userController.UserModel.value.uid)
      .collection('Restaurants').get();
    if(query.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void otpController(String otp) async{
    var isVerified = await verifyOtp(otp);
    if(isVerified){
      await getUserId();
      bool isCollectionExist =await checkRestaurants();
      if(isCollectionExist){
        Get.to(CheckRestaurants(),duration:const Duration(milliseconds: 50),transition: Transition.rightToLeft);
      }else{
        Get.to(RegisterPage(),duration:const Duration(milliseconds: 50),transition: Transition.rightToLeft);
      }
    }
  }

  Future<void> logOut() async{
    await auth.signOut();
    Get.offAll(Login());
  }
}