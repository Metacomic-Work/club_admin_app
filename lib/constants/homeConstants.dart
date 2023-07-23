import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeConstants{

  static List<FlashyTabBarItem> flashyTabBarItems = [
    FlashyTabBarItem(
      icon:const Icon(Icons.food_bank,color: Color.fromARGB(255, 48, 43, 43),size: 25,),
      title:const Text('Home',style: TextStyle(color: Colors.black),),
    ),
    FlashyTabBarItem(
      icon:const Icon(Icons.menu_rounded,color: Colors.black,size: 25,),
      title:const Text('Menu',style: TextStyle(color: Colors.black),),
    ),
    FlashyTabBarItem(
      icon:const Icon(Icons.event,size:25,color: Colors.black,),
      title:const Text('events',style: TextStyle(color: Colors.black),),
    ),
    FlashyTabBarItem(
      icon:const Icon(Icons.insights_rounded,size: 25,color: Colors.black,),
      title:const Text('Insights',style: TextStyle(color: Colors.black),),
    ),
  ];
}