//
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

bool isDj = false;

final userName = TextEditingController();
final userPhoneNo = TextEditingController();
final userEmail = TextEditingController();
final userarea = TextEditingController();
final userLandmark = TextEditingController();
final userCity = TextEditingController();
final userPincode = TextEditingController();

final startTime = TextEditingController();
final endTime = TextEditingController();
dynamic dateOfBirth = TextEditingController();

final _formKey = GlobalKey<FormState>();
String restoType = "Gender";
File? logoImage;
@override
var val = 0;

class registerResto extends StatefulWidget {
  const registerResto({Key? key}) : super(key: key);
  @override
  _registerRestoState createState() => _registerRestoState();
}

class _registerRestoState extends State<registerResto> {
  @override
  Widget build(BuildContext context) {
    dynamic height = MediaQuery.sizeOf(context).height;
    dynamic width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          physics: const ScrollPhysics(),
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
                            onTap: () {},
                            child:
                                const Icon(Icons.arrow_back_ios_new_rounded))),
                    Center(
                      child: Text(
                        "Register Restaurant",
                        style: TextStyle(
                            color: Color.fromARGB(255, 48, 47, 47),
                            fontFamily: 'sen',
                            fontSize: height * 0.029),
                      ),
                    ),
                    const Center(child: Icon(Icons.emoji_emotions)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilder(
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
                            child: FormBuilderTextField(
                              controller: userName,
                              name: "UserName",
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
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 30,
                            left: 24,
                            right: 24,
                          ),
                          child: SizedBox(
                            height: 50,
                            child: FormBuilderTextField(
                              controller: userPhoneNo,
                              name: "UserPhoneNo",
                              cursorColor: Colors.grey,
                              textAlignVertical: TextAlignVertical.top,
                              keyboardType: TextInputType.number,
                              cursorRadius: const Radius.circular(20),
                              decoration: InputDecoration(
                                labelText: "Phone No",
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
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 30,
                            left: 24,
                            right: 24,
                          ),
                          child: SizedBox(
                            height: 50,
                            child: FormBuilderTextField(
                              controller: userEmail,
                              name: "Email",
                              cursorColor: Colors.grey,
                              textAlignVertical: TextAlignVertical.top,
                              keyboardType: TextInputType.emailAddress,
                              cursorRadius: const Radius.circular(20),
                              decoration: InputDecoration(
                                labelText: "Email",
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
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 25, left: 24, right: 24),
                            child: SizedBox(
                              height: height * 0.07,
                              child: FormBuilderDropdown<String>(
                                name: "Resturant type",
                                dropdownColor:
                                    const Color.fromARGB(255, 39, 39, 39),
                                borderRadius: BorderRadius.circular(10),
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 197, 195, 195),
                                  fontFamily: 'sen',
                                ),
                                icon: const Icon(Icons.arrow_drop_down_rounded),
                                decoration: InputDecoration(
                                  hintText: "Resturant type",
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
                                    value: "Family Restaurant",
                                    child: Text("Family Restaurant"),
                                  ),
                                  DropdownMenuItem(
                                    value: "Bar & cafe",
                                    child: Text("Bar"),
                                  ),
                                  DropdownMenuItem(
                                    value: "Cafe",
                                    child: Text("Cafe"),
                                  )
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    restoType = value!;
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
                                height: height * 0.07,
                                width: width * 0.33,
                                child: FormBuilderTextField(
                                  name: "Resto start time",
                                  controller: startTime,
                                  cursorColor: Colors.grey,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  cursorRadius: const Radius.circular(20),
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    hintText: "Start time",
                                    suffix: InkWell(
                                      onTap: () {
                                        startTimePicking();
                                      },
                                      child: const Icon(
                                        Icons.calendar_month_rounded,
                                        color:
                                            Color.fromARGB(255, 197, 195, 195),
                                      ),
                                    ),
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
                              SizedBox(
                                child: Text("To"),
                              ),
                              SizedBox(
                                height: height * 0.07,
                                width: width * 0.33,
                                child: FormBuilderTextField(
                                  name: "Resto End time",
                                  controller: endTime,
                                  cursorColor: Colors.grey,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  cursorRadius: const Radius.circular(20),
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    hintText: "End time",
                                    suffix: InkWell(
                                      onTap: () {
                                        endTimePicking();
                                      },
                                      child: const Icon(
                                        Icons.calendar_month_rounded,
                                        color:
                                            Color.fromARGB(255, 197, 195, 195),
                                      ),
                                    ),
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
                            ],
                          ),
                        ),
                        if (logoImage != null)
                          Padding(
                            padding:
                                EdgeInsets.only(top: 25, left: 24, right: 24),
                            child: SizedBox(
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    print("Taped");
                                  },
                                  child: Container(
                                    height: height * 0.12,
                                    width: width * 0.26,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: FileImage(logoImage!),
                                          fit: BoxFit.cover),
                                      color: const Color.fromARGB(
                                          255, 206, 206, 206),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        else
                          Padding(
                            padding:
                                EdgeInsets.only(top: 25, left: 24, right: 24),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  getImage(source: ImageSource.gallery);
                                });
                              },
                              child: Container(
                                height: height * 0.12,
                                width: width * 0.26,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      const Color.fromARGB(255, 206, 206, 206),
                                ),
                                child: Center(
                                    child: Icon(Icons.add_a_photo_rounded)),
                              ),
                            ),
                          ),
                        const Padding(
                          padding: EdgeInsets.only(top: 25),
                          child: Column(children: [
                            Divider(),
                            Text(
                              "Address",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'sen',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Divider(),
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 30,
                            left: 24,
                            right: 24,
                          ),
                          child: SizedBox(
                            height: 50,
                            child: FormBuilderTextField(
                              controller: userarea,
                              name: "area",
                              cursorColor: Colors.grey,
                              textAlignVertical: TextAlignVertical.top,
                              keyboardType: TextInputType.multiline,
                              cursorRadius: const Radius.circular(20),
                              decoration: InputDecoration(
                                labelText: "area",
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
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 30,
                            left: 24,
                            right: 24,
                          ),
                          child: SizedBox(
                            height: 50,
                            child: FormBuilderTextField(
                              controller: userLandmark,
                              name: "Landmark",
                              cursorColor: Colors.grey,
                              textAlignVertical: TextAlignVertical.top,
                              keyboardType: TextInputType.multiline,
                              cursorRadius: const Radius.circular(20),
                              decoration: InputDecoration(
                                labelText: "LandMark",
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
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 30,
                            left: 24,
                            right: 24,
                          ),
                          child: SizedBox(
                            height: 50,
                            child: FormBuilderTextField(
                              controller: userCity,
                              name: "City",
                              cursorColor: Colors.grey,
                              textAlignVertical: TextAlignVertical.top,
                              keyboardType: TextInputType.name,
                              cursorRadius: const Radius.circular(20),
                              decoration: InputDecoration(
                                labelText: "City",
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
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 30,
                            left: 24,
                            right: 24,
                          ),
                          child: SizedBox(
                            height: 50,
                            child: FormBuilderTextField(
                              controller: userPincode,
                              name: "area Pincode",
                              cursorColor: Colors.grey,
                              textAlignVertical: TextAlignVertical.top,
                              keyboardType: TextInputType.number,
                              cursorRadius: const Radius.circular(20),
                              decoration: InputDecoration(
                                labelText: "Area Pincode",
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
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 54, 54, 54)),
                              onPressed: () {},
                              child: const Text(
                                "Update Profile",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 197, 195, 195),
                                  fontFamily: 'sen',
                                  fontSize: 18,
                                ),
                              )),
                        ),
                      ]),
                ),
              )
            ],
          ))),
    );
  }

  Future<void> startTimePicking() async {
    final Time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (Time != null) {
      startTime.text = Time.format(context);
    }
  }

  Future<void> endTimePicking() async {
    final Time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (Time != null) {
      endTime.text = Time.format(context);
    }
  }

  void getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source);

    if (file?.path != null) {
      setState(() {
        logoImage = File(file!.path);
      });
    }
  }
}
