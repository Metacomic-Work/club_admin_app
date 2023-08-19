import 'package:club_admin/controllers/offerController.dart';
import 'package:club_admin/views/authentication/checkRestaurants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class addOffer extends StatefulWidget {
  const addOffer({super.key});

  @override
  State<addOffer> createState() => _addOfferState();
}


class _addOfferState extends State<addOffer> {
  OfferController offerController = Get.put(OfferController());

  @override
  Widget build(BuildContext context){
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return  Scaffold(
      bottomNavigationBar: GestureDetector(
        child: Padding(
          padding: EdgeInsets.all(12),
          child:Container(
            width: w,
            height: h * 0.06,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: const Color.fromARGB(255, 31, 31, 31)
            ),
            child: Center(child: Text("Add an offer",style: TextStyle(fontFamily: 'sen',fontSize: 18,color: Colors.white),)),
      
          )
        ),
        onTap: (){
          if(offerController.formValidator()){
            offerController.addOffer();
            const msg =SnackBar(content: Text('Offer added Successful'),backgroundColor:Color.fromARGB(255, 31, 205, 39),
              elevation: 10,
              behavior: SnackBarBehavior.floating,
              margin:EdgeInsets.all(5),
              duration: Duration(seconds: 2),
            );
            ScaffoldMessenger.of(context).showSnackBar(msg);
          }else{
            const msg =SnackBar(content: Text('Please Enter all fields'),backgroundColor:Color.fromARGB(255,255,62,36),
              elevation: 10,
              behavior: SnackBarBehavior.floating,
              margin:EdgeInsets.all(5),
              duration: Duration(seconds: 2),
            );
            ScaffoldMessenger.of(context).showSnackBar(msg);
          }
        },
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                Container(
                  width: w * 0.95,
                  height: h * 0.06,
                  color: const Color.fromARGB(255, 243, 243, 243),
                  child:const Padding(
                    padding: EdgeInsets.only(left: 15,top: 10),
                    child: Text("Create Offer",style: TextStyle(fontFamily:'sen',fontSize: 20,color: Colors.black),),
                  ),
      
                ),
                const SizedBox(height: 20,),
                CustomInput(title: 'Offer Heading', hint: '50% off upto 150', controller: offerController.heading),
                CustomInput(title: 'Offer', hint: '50%', controller: offerController.offer,type: TextInputType.number,maxLength: 3),
                CustomInput(title: 'Coupon Code', hint: 'CLUBIND', controller:offerController.code),
                const SizedBox(height: 40,),
      
              ],
            ),
          )
        ),
      ),
    );
  }
}

  CustomInput(
      {required String title,
      required String hint,
      required controller,
      type,
      maxLength,
      Widget? widget}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          widget ??
              TextField(
                controller: controller,
                keyboardType:type ,
                maxLength: maxLength,
                onChanged: (value) => controller = value,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black)),
                    hintText: hint,
                    hintStyle: const TextStyle(fontSize: 15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              )
        ],
      ),
    );
  }
