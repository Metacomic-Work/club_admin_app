import 'package:flutter/material.dart';

class MenuConstants{
   
   static List<DropdownMenuItem> ItemType = [
      const DropdownMenuItem(
        value: "Veg",
        child: Text("Veg"),
      ),
      const DropdownMenuItem(
        value: "Non-Veg",
        child: Text("Non-Veg"),
      ),
      const DropdownMenuItem(
        value: "Egg",
        child: Text("Egg"),
      ),
   ];
}
