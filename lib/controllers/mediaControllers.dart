import 'package:club_admin/models/itemModel.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';


class MediaController extends GetxController{


  Rx<ItemModel> itemModel = ItemModel().obs;

 

  Future<File?> getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source);

    if (file?.path != null) {
      return File(file!.path);
      
    }
  }
}



class Med extends StatefulWidget {
  const Med({super.key});

  @override
  State<Med> createState() => _MedState();
}

class _MedState extends State<Med> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}