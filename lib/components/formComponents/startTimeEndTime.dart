import 'package:club_admin/controllers/restaurantController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

dynamic startTimeController = TextEditingController();
dynamic endTimeController = TextEditingController();

class StartEndTime {
  RestaurantController restaurantController = Get.put(RestaurantController());

  Widget startEndTime(context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 0, right: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: height * 0.07,
            width: width * 0.4,
            child: FormBuilderTextField(
              name: "Resto start time",
              readOnly: true,
              enabled: true,
              onTap: () {
                startTimePicking(context);
              },
              controller: startTimeController,
              cursorColor: Colors.grey,
              textAlignVertical: TextAlignVertical.bottom,
              cursorRadius: const Radius.circular(20),
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: "Start time",
                suffix: const Icon(
                  Icons.calendar_month_rounded,
                  color: Color.fromARGB(255, 197, 195, 195),
                ),
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
            ),
          ),
          SizedBox(
            child: Text("To"),
          ),
          SizedBox(
            height: height * 0.07,
            width: width * 0.4,
            child: FormBuilderTextField(
              name: "Resto End time",
              readOnly: true,
              enabled: true,
              onTap: () {
                endTimePicking(context);
              },
              controller: endTimeController,
              cursorColor: Colors.grey,
              textAlignVertical: TextAlignVertical.bottom,
              cursorRadius: const Radius.circular(20),
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: "End time",
                suffix: const Icon(
                  Icons.calendar_month_rounded,
                  color: Color.fromARGB(255, 197, 195, 195),
                ),
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
            ),
          ),
        ],
      ),
    );
  }

  Future<void> startTimePicking(context) async {
    final Time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (Time != null) {
      restaurantController.restaurantModel.value.startTime = Time.format(context);
      startTimeController.text = Time.format(context);
    }
  }

  Future<void> endTimePicking(context) async {
    final Time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (Time != null) {
      endTimeController.text = Time.format(context);
      restaurantController.restaurantModel.value.endTime = Time.format(context);
    }
  }
}
