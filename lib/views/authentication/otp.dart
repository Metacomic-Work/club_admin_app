
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pinput/pinput.dart';

import '../../controllers/authController.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  var code = '';
  authController controller = Get.put(authController());
  
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12, top: 190),
                    child:Pinput(
                      length: 6,
                      showCursor: true,
                      controller:controller.textEditingController,
                      onChanged: (pin){
                        controller.code.value = pin!;
                      },
                      onCompleted: (pin) => {
                        controller.code.value = pin,
                      },
                      onSubmitted: (pin) =>{
                        controller.code.value = pin,
                      },
                    )),
                  
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                          text: "Don't get code ?",
                          style: TextStyle(color: Colors.white)),
                      TextSpan(
                          text: "  Resend code",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 109, 157, 197),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          recognizer: TapGestureRecognizer()..onTap = () {}),
                    ])),
                  ),
                  SizedBox(height: h * 0.05,),
                  InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              height: 50,
                              width: w * 0.89,
                              decoration:BoxDecoration(
                                border: Border.all(color: Color.fromARGB(255, 59, 59, 59),width: 2),
                                color: Color.fromARGB(255, 33, 33, 33),
                                borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              child: Center(
                                child: Text("Verify",style: GoogleFonts.lexend(fontSize: 20,color: Colors.white),),
                              ),
                            ),
                          ),
                          onTap: ()async{
                           controller.otpController(controller.code.value);
                           controller.getUserId();
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
