import 'dart:io';
import 'package:club_admin/controllers/authController.dart';
import 'package:club_admin/services/notificationServices.dart';
import 'package:club_admin/views/authentication/login.dart';
import 'package:club_admin/views/authorised/registerResto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../controllers/userController.dart';

final nameController = TextEditingController();
dynamic dobController = TextEditingController();

final _formKey1 = GlobalKey<FormState>();

@override
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  UserController userController = Get.put(UserController());
  AuthController authController = Get.put(AuthController());
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authController.getUserId();
    notificationServices.getDeviceToken();
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    
      return Scaffold(
        backgroundColor:
            userController.UserModel.value.isDj! ? Colors.black : Color.fromARGB(255, 255, 255, 255),
        body: SafeArea(
          child: SingleChildScrollView(
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
                        Center(
                            child: InkWell(
                                onTap: () {
                                    Get.off(Login(),
                                    duration: Duration(seconds: 1), //duration of transitions, default 1 sec
                                    transition: Transition.rightToLeft
                                  );
                                },
                                child:
                                    const Icon(Icons.arrow_back_ios_new_rounded))),
                        Center(
                          child: Text(
                            "Profile",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 197, 195, 195),
                                fontFamily: 'sen',
                                fontSize: height * 0.029),
                          ),
                        ),
                        const Center(child: Icon(Icons.emoji_emotions)),
                      ],
                    ),
                  ),
                  if (userController.UserModel.value.imagePath != null)
                    SizedBox(
                      child: Center(
                          child: GestureDetector(
                        onTap: () {
                          Get.bottomSheet(Container(
                            height: height * 0.11,
                            width: width * 0.99,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 29, 29, 29),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          userController.UserModel.value.imagePath = null;
                                        });
                                        Get.back();
                                      },
                                      child: const Text(
                                        "Delete Image",
                                        style: TextStyle(
                                            color:Color.fromARGB(255, 197, 195, 195),
                                            fontFamily: 'sen',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          getImage(source: ImageSource.gallery);
                                        });
                                        Get.back();
                                      },
                                      child: const Text(
                                        "Update Image",
                                        style: TextStyle(
                                            color:Color.fromARGB(255, 197, 195, 195),
                                            fontFamily: 'sen',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                          ));
                        },
                        child: Container(
                          height: height * 0.14,
                          width: width * 0.40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color.fromARGB(255, 197, 195, 195),
                              image: DecorationImage(
                                image: FileImage(File(userController.UserModel.value.imagePath!)),
                                fit: BoxFit.cover,
                              )),
                        ),
                      )),
                    )
                  else
                    SizedBox(
                      child: Center(
                        child: InkWell(
                          onTap: () {
                             getImage(source: ImageSource.gallery);
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: height * 0.08,
                            child: const Icon(Icons.add_a_photo_rounded),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10,),
                        Text(
                          "+91 6309742060",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 197, 195, 195),
                            fontFamily: 'sen',
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.all(10.0),
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
                                    labelStyle: const TextStyle(color: Color.fromARGB(255, 197, 195, 195),
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
                                    userController.UserModel.value.name = nameController.text;
                                  },
                                ),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 25, left: 24, right: 24),
                                child: SizedBox(
                                  height: 60,
                                  child: DropdownButtonFormField<String>(
                                    hint: const Text(
                                      "Select Gender",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 197, 195, 195),
                                        fontFamily: 'sen',
                                      ),
                                    ),
                                    dropdownColor:
                                        const Color.fromARGB(255, 39, 39, 39),
                                    borderRadius: BorderRadius.circular(10),
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 197, 195, 195),
                                      fontFamily: 'sen',
                                    ),
                                    icon: const Icon(Icons.arrow_drop_down_rounded),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color:
                                                Color.fromARGB(255, 197, 195, 195)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            const BorderSide(color: Colors.grey),
                                      ),
                                    ),
                                    items: const [
                                      DropdownMenuItem(
                                        value: "Male",
                                        child: Text("Male"),
                                      ),
                                      DropdownMenuItem(
                                        value: "Female",
                                        child: Text("Female"),
                                      ),
                                      DropdownMenuItem(
                                        value: "Transgender",
                                        child: Text("Transgender"),
                                      )
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        userController.UserModel.value.gender = value!;
                                      });
                                    },
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 25, left: 24, right: 24),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: 230,
                                    child: TextFormField(
                                      controller: dobController,
                                      cursorColor: Colors.grey,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      cursorRadius: const Radius.circular(20),
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        hintText: "Enter date of birth",
                                        labelStyle: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 197, 195, 195),
                                            fontFamily: 'sen'),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color:
                                                Color.fromARGB(255, 197, 195, 195),
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
                                    ),
                                  ),
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.only(
                                            top: 13, bottom: 13),
                                        backgroundColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    onPressed: () {
                                      datepicking();
                                    },
                                    child: const Icon(
                                      Icons.calendar_month_rounded,
                                      color: Color.fromARGB(255, 197, 195, 195),
                                    ),
                                  )
                                ],
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
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        "I'm DJ",
                                        style: TextStyle(
                                          color: userController.UserModel.value.isDj!
                                              ? const Color.fromARGB(
                                                  255, 231, 231, 231)
                                              : const Color.fromARGB(
                                                  255, 197, 195, 195),
                                        ),
                                      ),
                                    ),
                                    CupertinoSwitch(
                                      activeColor: Colors.blue,
                                      value: userController.UserModel.value.isDj!,
                                      onChanged: (value) {
                                        setState(() {
                                          userController.UserModel.value.isDj = value;
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                           InkWell(
                            child: Padding(
                            padding: const EdgeInsets.only(top: 40),
                              child: Container(
                              height: 50,
                              width: width * 0.83,
                              decoration:BoxDecoration(
                                border: Border.all(color:const Color.fromARGB(255, 59, 59, 59),width: 2),
                                color: const Color.fromARGB(255, 27, 27, 27),
                                borderRadius:const BorderRadius.all(Radius.circular(10))
                              ),
                              child:const Center(
                                child: Text("Update Profile",style: TextStyle(fontFamily: 'sen',fontSize: 20,color: Colors.white)),
                              ),
                            ),
                          ),
                          onTap: ()async{
                              await userController.uploadProfileImage(userController.UserModel.value.imagePath);
                              userController.registerUser();
                              userController.registerOwner();
                              Get.to(RegisterRestaurant());
        
                            },
                          ),
                        ]
                      ),
                    ),
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
        userController.UserModel.value.dob = dateofbirth.toString().split(" ")[0];
        dobController.text = userController.UserModel.value.dob;
      });
      
    }
  }

  void getImage({required ImageSource source}) async {


    XFile? file = await ImagePicker().pickImage(source: source);

    if (file?.path != null) {
      setState(() {
        userController.UserModel.value.imagePath = file!.path;
      });
    }
  }
}
