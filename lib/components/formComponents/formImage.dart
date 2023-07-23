import 'dart:io';

import 'package:club_admin/controllers/restaurantController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';



class FormImage extends StatefulWidget {
  const FormImage({Key? key}) : super(key: key);
  @override
  _FormImageState createState() => _FormImageState();
}

class _FormImageState extends State<FormImage> {
  RestaurantController restaurantController = Get.put(RestaurantController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        if (restaurantController.restaurantModel.value.imagePath != null)
          Padding(
            padding: EdgeInsets.only(top: 10, left: 4, right: 4),
            child: SizedBox(
              child: Center(
                child: Stack(children: [
                  Container(
                    height: height * 0.45,
                    width: width * 0.99,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: FileImage(File(restaurantController.restaurantModel.value.imagePath!)), fit: BoxFit.cover),
                      color: const Color.fromARGB(255, 206, 206, 206),
                    ),
                  ),
                  Positioned(
                    height: height * 0.07,
                    child: ButtonBar(children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            restaurantController.restaurantModel.value.restaurantImage = null;
                          });
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.delete_outline_rounded,
                            size: height * 0.04,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          getImage(source: ImageSource.gallery);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            shape: BoxShape.rectangle,
                          ),
                          child: Icon(
                            Icons.image_rounded,
                            size: height * 0.04,
                          ),
                        ),
                      ),
                    ]),
                  )
                ]),
              ),
            ),
          )
        else
          Padding(
            padding: EdgeInsets.only(top: 25, left: 24, right: 24),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  getImage(source: ImageSource.gallery);
                });
              },
              child: Hero(
                tag: "hello",
                child: Container(
                  height: height * 0.12,
                  width: width * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 206, 206, 206),
                  ),
                  child: Center(child: Icon(Icons.add_a_photo_rounded)),
                ),
              ),
            ),
          ),
      ],
    );
  }

  void getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source);

    if (file?.path != null) {
      setState(() {
        restaurantController.restaurantModel.value.imagePath = file!.path;
      });
    }
  }
}
