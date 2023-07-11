import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';



final nameController = TextEditingController();
dynamic dobController = TextEditingController();
final _formKey = GlobalKey<FormState>();

File? profileImage;

class RegisterResto extends StatefulWidget {
  const RegisterResto({super.key});

  @override
  State<RegisterResto> createState() => _RegisterRestoState();
} 

class _RegisterRestoState extends State<RegisterResto> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: SizedBox(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 25, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width * 0.9,
                        child: Text('Register your Resto as Owner',style: TextStyle(fontFamily: 'sen',fontSize: 30,),))
                    ],
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 30,
                              left: 24,
                              right: 24,
                            ),
                            child: SizedBox(
                              height: 50,
                              child: TextFormField(
                                controller: nameController,
                                cursorColor: Colors.grey,
                                textAlignVertical: TextAlignVertical.top,
                                keyboardType: TextInputType.name,
                                cursorRadius: const Radius.circular(20),
                                decoration: InputDecoration(
                                  labelText: "Name",
                                  labelStyle: const TextStyle(
                                      color: Color.fromARGB(255, 197, 195, 195),
                                      fontFamily: 'sen'),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 197, 195, 195),
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                onChanged:(val){
                                  
                                },
                              ),
                            ),
                          ),
                          
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 25, left: 24, right: 24),
                            child: Container(
                              height: height * 0.07,
                              width: width * 0.9,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      "I'm DJ",
                                      style: TextStyle(
                                        color: Colors.white
                                      ),
                                    ),
                                  ),
                                  CupertinoSwitch(
                                    activeColor: Colors.blue,
                                    value: false,
                                    onChanged: (value) {
                                      setState(() {
                                        
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 50,),
                         InkWell(
                          child: Padding(
                          padding: const EdgeInsets.only(top: 00),
                            child: Container(
                            height: 50,
                            width: width * 0.83,
                            decoration:BoxDecoration(
                              border: Border.all(color: Color.fromARGB(255, 59, 59, 59),width: 2),
                              color: Color.fromARGB(255, 27, 27, 27),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child:const Center(
                              child: Text("Update Profile",style: TextStyle(fontFamily: 'sen',fontSize: 20)),
                            ),
                          ),
                        ),
                        onTap: ()async{
                            
                          },
                        ),
                      ]
                    ),
                  ),
                )
              ],
            )
          )
        ),
      ),
    );
  }

  Future<void> datepicking() async {
    final dateofbirth = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
    );
    if (dateofbirth != null) {
      setState(() {
        
      });
      
    }
  }

  void getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source);

    if (file?.path != null) {
      setState(() {
        profileImage = File(file!.path);
      });
    }
  }
}

