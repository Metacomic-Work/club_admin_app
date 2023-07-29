import 'package:club_admin/views/authentication/checkRestaurants.dart';
import 'package:club_admin/views/authentication/login.dart';
import 'package:club_admin/views/authorised/home.dart';
import 'package:club_admin/views/authorised/registerResto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
} 



class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
      if(auth.currentUser != null){
        return  GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(useMaterial3: true),
        home:const Scaffold(
          body: Center(
            child: Home(),
          ),
        ),
      );
    }else{
      return  GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(useMaterial3: true),
        home:const Scaffold(
          body: Center(
            child: Login(),
          ),
        ),
      );
    }
  }
}