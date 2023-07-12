import 'dart:io';

import 'package:club_admin/constants/menuConstants.dart';
import 'package:club_admin/controllers/mediaControllers.dart';
import 'package:club_admin/controllers/menuItemsController.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

class AddMenu extends StatefulWidget {
  const AddMenu({super.key});

  @override
  State<AddMenu> createState() => _AddMenuState();
}

class _AddMenuState extends State<AddMenu> {

  MenuItemController menuItemController = Get.put(MenuItemController());
  MediaController mediaController = Get.put(MediaController());
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final _formKey = GlobalKey<FormBuilderState>();
    

    return  Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(menuItemController.itemModel.value.itemImage != null)
                Container(
                  width:w,
                  height: h * 0.3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(menuItemController.itemModel.value.itemImage!),
                      fit: BoxFit.cover,
                    )
                  ),
              )else 
                Container(
                  width:w,
                  height: h * 0.3,
                  color: Color.fromARGB(255, 222, 222, 222),
                  child: Center(
                    child: InkWell(
                      onTap: (){
                        getImage(source: ImageSource.gallery);
                      },
                      child:const CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.add_a_photo_rounded),
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 20,),
              FormBuilder(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormBuilderTextField(
                        name: 'Item_Name',
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Restaurant Name',
                          border: OutlineInputBorder(),
                        ), 
                      ),
                      const SizedBox(height: 20,),
                      FormBuilderTextField(
                        name: 'Item_Price',
                        keyboardType: TextInputType.number,
                        decoration:const InputDecoration(
                          labelText: 'Item Price',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      FormBuilderTextField(
                        maxLines: 3,
                        name: 'Item_Description',
                        keyboardType: TextInputType.name,
                        decoration:const InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      FormBuilderDropdown(
                        name: "Item_Type",
                        decoration:const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Item Type'
                        ),
                        items: MenuConstants.ItemType
                      ),
                      FormBuilderTextField(
                        name: 'servings ',
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Restaurant Name',
                          border: OutlineInputBorder(),
                        ), 
                      ),
                    ],
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }




  void getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source);

    if (file?.path != null) {
      setState(() {
        menuItemController.itemModel.value.itemImage = File(file!.path);
      });
    }
  }
}