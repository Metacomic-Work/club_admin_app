
import "package:club_admin/controllers/userController.dart";
import "package:club_admin/views/authentication/register.dart";
import "package:club_admin/views/authorised/registerResto.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";






class authController extends GetxController{
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


  void getUserId() async{
    final FirebaseAuth CurrentUser = FirebaseAuth.instance;
    final User? user = CurrentUser.currentUser;
    final uid = user?.uid;
    userController.UserModel.value.uid = uid;
    print(uid);
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
  

  void otpController(String otp) async{
    var isVerified = await verifyOtp(otp);
    isVerified ? Get.offAll(RegisterPage(),
      duration: Duration(milliseconds: 50), //duration of transitions, default 1 sec
      transition: Transition.rightToLeft
    ) : Get.back();
  }

}