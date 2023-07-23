import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

Widget textField(
    {context,
    required final name,
    required final controller,
    required final label,
    required final keybordtype}) {
  return Padding(
    padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
    child: SizedBox(
      height: 50,
      child: FormBuilderTextField(
        controller: controller,
        name: "UserName",
        cursorColor: const Color.fromARGB(255, 31, 31, 31),
        textAlignVertical: TextAlignVertical.top,
        keyboardType: keybordtype,
        cursorRadius: const Radius.circular(20),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
              color: Color.fromARGB(255, 38, 38, 38), fontFamily: 'sen'),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 188, 188, 188),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 21, 21, 21),
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
  );
}
