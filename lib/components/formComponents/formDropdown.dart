import 'package:club_admin/controllers/restaurantController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

dynamic restoType = "Resto type";

class FormDropdown extends StatefulWidget {
  const FormDropdown({Key? key}) : super(key: key);

  @override
  _FormDropdownState createState() => _FormDropdownState();
}

class _FormDropdownState extends State<FormDropdown> {
  RestaurantController restaurantController = Get.put(RestaurantController());
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Padding(
        padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
        child: SizedBox(
          height: height * 0.07,
          child: FormBuilderDropdown<String>(
            name: "Resto Type",
            dropdownColor: Color.fromARGB(255, 231, 231, 231),
            borderRadius: BorderRadius.circular(10),
            style: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontFamily: 'sen',
            ),
            icon: const Icon(Icons.arrow_drop_down_rounded),
            decoration: InputDecoration(
              hintText: "Select Type",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: Color.fromARGB(255, 197, 195, 195)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
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
                restaurantController.restaurantModel.value.type = value!;
              });
            },
          ),
        ));
  }
}
