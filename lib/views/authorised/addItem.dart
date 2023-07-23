import 'dart:io';
import 'package:club_admin/components/formComponents/formImage.dart';
import 'package:club_admin/controllers/restaurantController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../components/formComponents/formDropdown.dart';
import '../../components/formComponents/formTextField.dart';
import '../../components/formComponents/startTimeEndTime.dart';
import '../../constants/menuConstants.dart';
import '../../controllers/menuItemsController.dart';


final itemNameController = TextEditingController();
final itemPriceController = TextEditingController();
final itemTypeController = TextEditingController();
final itemDesController = TextEditingController();
String val = 'Veg';


@override
class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  
  RestaurantController restaurantController = Get.put(RestaurantController());
  MenuItemController menuItemController = Get.put(MenuItemController());


  @override
  Widget build(BuildContext context) {
    dynamic h = MediaQuery.sizeOf(context).height;
    dynamic w = MediaQuery.sizeOf(context).width;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
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
                              child:const Icon(Icons.arrow_back_ios_new_rounded))),
                      Center(
                        child: Text("Add Item",style: TextStyle(color: Color.fromARGB(255, 48, 47, 47),fontFamily: 'sen',
                              fontSize: h * 0.029),
                        ),
                      ),
                      const Center(child: Icon(Icons.emoji_emotions)),
                    ],
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:  Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if(menuItemController.itemModel.value.imagePath != null)
                            Container(
                              width:w,
                              height: h * 0.3,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: FileImage(File(menuItemController.itemModel.value.imagePath!)),
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
                                const SizedBox(height: 20,),
                          TextField(
                            keyboardType: TextInputType.name,
                            controller: itemNameController,
                            decoration:const InputDecoration(
                            labelText: 'Item Name',
                            border: OutlineInputBorder(),
                            ), 
                            onChanged: (val){
                              menuItemController.itemModel.value.itemName = itemNameController.text;
                            },
                          ),
                          SizedBox(height: 20,),
                          TextField(
                            keyboardType: TextInputType.number,
                            controller: itemPriceController,
                            decoration:const InputDecoration(
                            labelText: 'Item Price',
                            border: OutlineInputBorder(),
                            ), 
                            onChanged: (val){
                              menuItemController.itemModel.value.price = itemPriceController.text;
                            },
                          ),
                          Container(
                            width: w * 1,
                            height: h * 0.1,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left:30.0,right: 30),
                                child: DropdownButton(     
                                  value: menuItemController.itemModel.value.itemType,
                                  items: MenuConstants.ItemType,
                                  isExpanded: true,
                                  onChanged: (value){
                                    setState(() {
                                       menuItemController.itemModel.value.itemType = value;
                                    });
                                  },
                                  
                                ),
                              ),
                            ),
                          ),
                          TextField(
                            maxLines: 2,
                            controller: itemDesController, 
                            keyboardType: TextInputType.name,
                            decoration:const InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(),
                            ),
                            onChanged: (val){
                              menuItemController.itemModel.value.description = itemDesController.text;
                            },
                          ),
                          
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:const Color.fromARGB(255, 54, 54, 54)),
                                onPressed: () async {
                                  await menuItemController.uploadItemImage(menuItemController.itemModel.value.imagePath);
                                  menuItemController.addItem();
                                },
                                child: const Text(
                                  "Add Item",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 197, 195, 195),
                                    fontFamily: 'sen',
                                    fontSize: 18,
                                  ),
                                )),
                          ),
                        ]),
                  ),
              ],
            )
            )
          ),
      ),
    );
  }

  void getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source);

    if (file?.path != null) {
      setState(() {
        menuItemController.itemModel.value.imagePath = file!.path;
      });
    }
  }
}


/*import 'dart:io';

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
                      const SizedBox(height: 20,),
                      FormBuilderDropdown(
                        name: "Item_Type",
                        decoration:const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Item Type'
                        ),
                        items: MenuConstants.ItemType
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




  
}

*/





/*





FormBuilderTextField(
  name: 'Item_Name',
  keyboardType: TextInputType.name,
  decoration: const InputDecoration(
    labelText: 'Restaurant Name',
       border: OutlineInputBorder(),
    ), 
  ),


*/ 