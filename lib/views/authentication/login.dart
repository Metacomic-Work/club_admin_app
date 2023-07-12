
import 'package:club_admin/views/authentication/otp.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../controllers/authController.dart';
import '../../controllers/userController.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  authController controller = Get.put(authController());
  UserController userController = Get.put(UserController());


  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;
    final sw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 27, 27, 27),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: sw,
                  height: sh * 0.4,
                  decoration:const BoxDecoration(
                    image: DecorationImage( 
                      image: NetworkImage("https://images.pexels.com/photos/699953/pexels-photo-699953.jpeg"),
                      fit: BoxFit.cover,
                    )
                  )
                ),
                Container(
                  width: sw,
                  height: sh * 0.4,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                       Color.fromARGB(255, 0, 0, 0).withOpacity(0.0),
                       Color.fromARGB(191, 26, 26, 26),
                      ],stops: const [
                        0.0,
                        1.0
                        ]
                      )
                    ),
                )
              ],
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Login or Sign in with..",style: GoogleFonts.sen(fontSize: 25,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 228, 228, 228)),),
                  const SizedBox(height: 16,),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      height: 45,
                      width: sw,
                      decoration:const BoxDecoration(
                        color: Color.fromARGB(255, 45, 45, 45),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 7,),
                          Text("+91",style: GoogleFonts.sen(fontSize: 16,color: Colors.grey),),
                          const SizedBox(width: 7,),
                          const VerticalDivider(width: 1,color: Color.fromARGB(255, 92, 92, 92),),
                          const SizedBox(width: 20,),
                          SizedBox(
                            height: 40,
                            width: sw * 0.7,
                            child: TextField(
                              keyboardType: TextInputType.phone,
                              controller: phoneController,
                              style: GoogleFonts.sen(),
                              decoration:const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Phone number",
                                hintStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255))
                              ),
                            ),
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: 50,
                        width: sw * 0.89,
                        decoration:BoxDecoration(
                          border: Border.all(color: Color.fromARGB(255, 59, 59, 59),width: 2),
                          color: Color.fromARGB(255, 33, 33, 33),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Center(
                          child: Text("Login",style: TextStyle(fontFamily: 'sen',fontSize: 20,color: Colors.white)),
                        ),
                      ),
                    ),
                    onTap: ()async{
                      userController.UserModel.value.phone = phoneController.text;
                      await controller.phoneVerification('+91${userController.UserModel.value.phone.toString()}');
                      Get.to( OtpPage(),
                        duration: Duration(seconds: 1), //duration of transitions, default 1 sec
                        transition: Transition.rightToLeft
                      );
                    },
                  ),
                  SizedBox(height: 10,),
                  HorizontalOrLine(label: "or", height: 10,sw: sw,),

                  SizedBox(height:sh * 0.05),
                  
                  SizedBox(height: 95,),
                  Container(
                    margin: EdgeInsets.only(left: 80),
                    child:Column(
                      children: [
                        Text("By Continuing you agree ",style: GoogleFonts.sen(fontSize: 12,color: Colors.grey),),
                        const SizedBox(height: 2,),
                        Text("Terms of Service   Privacy Policy ",style: GoogleFonts.sen(fontSize: 12,color: Colors.grey))
                      ],
                    ) ,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


class HorizontalOrLine extends StatelessWidget {
  const HorizontalOrLine({
    required this.label,
    required this.height,
    required this.sw,
  });

  final String label;
  final double height;
  final double sw;

  @override
  Widget build(BuildContext context) {

    return Row(children: <Widget>[
       Container(
        width: 100,
            margin: EdgeInsets.only(left: 50, right: 15.0),
            child: Divider(
              color: Colors.grey.shade500,
              height: height,
            )
          ),

      Text(label,style: GoogleFonts.sen(color: const Color.fromARGB(255, 131, 131, 131),fontWeight: FontWeight.bold),),

    
        Container(
          width: 100,
            margin: EdgeInsets.only(left: 15.0, right: 10.0),
            child: Divider(
              color: Colors.grey.shade500,
              height: height,
            )
        )
    ]);
  }
}