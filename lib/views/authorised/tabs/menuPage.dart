import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_admin/views/authorised/addBanner.dart';
import 'package:club_admin/views/authorised/addImages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:club_admin/controllers/menuItemsController.dart';
import 'package:club_admin/controllers/restaurantController.dart';
import 'package:club_admin/views/authorised/addItem.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  RestaurantController restaurantController = Get.put(RestaurantController());
  MenuItemController menuItemController = Get.put(MenuItemController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //restaurantController.getRestaurantData();
    //menuItemController.getMenuItemStream();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: (){
          Get.to(AddBanner());
        },
        child: Container(
          width: width * 0.3,
          height: height * 0.05,
          decoration:const BoxDecoration(
            color: Color.fromARGB(255, 31, 31, 31),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Center(
            child: Text("Add Banner",style: TextStyle(fontFamily: 'sen',color: Colors.white),),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          child: Container(
            width: width * 0.9,
            height: height * 0.05,
            decoration: BoxDecoration(  
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color.fromARGB(255, 64, 86, 244),
            ),
            child: Center(child: Text("Add Item",style: TextStyle(fontFamily: 'sen',fontSize: 20,color: Colors.white),)),
          ),
          onTap: (){
            Get.to(AddItem());
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child:Stack(
            children: [Column(
              children: [
                Container(
                  width: width,
                  height: height * 0.068,
                  decoration: BoxDecoration(
                    
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 15,left: 15),
                    child: Text("Menu",style: TextStyle(fontSize: 25,color: Colors.black,fontFamily: 'sen'),),
                  ),
                ),
                Container(height: 2,width: width,color: const Color.fromARGB(255, 212, 212, 212),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Container(
                        width: width * 0.26,
                        height: height * 0.11,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          image: DecorationImage(
                            image: NetworkImage(restaurantController.restaurantModel.value.restaurantImage.toString()),
                            fit: BoxFit.cover,
                          )                        
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Container(
                        width: width * 0.5,
                        height: height * 0.12,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(restaurantController.restaurantModel.value.restaurantName.toString(),style:const TextStyle(fontFamily: 'sen',fontSize: 22,color: Colors.black),),
                            const SizedBox(height: 5,),
                            Text(restaurantController.restaurantModel.value.type.toString(),style:const TextStyle(fontFamily: 'sen',fontSize: 12,color: Colors.grey),),
                          ],
                        ),
          
                      )
                    ],
                  ),
                ),
                Container(
                  height: height * 0.6,
                  width: width,
                  child: StreamBuilder(
                    stream: menuItemController.menuItemStream,
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                      if(snapshot.hasError){
                        return const Text("Something is Wrong");
                      }
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
                      }
                      if(snapshot.data!.docs.isEmpty){
                        return const Center(child:Text("No Items Added",style: TextStyle(fontSize: 20,fontFamily: 'sen'),));
                      }
                      if(snapshot.data != null){
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  width: width * 0.95,
                                  height: height * 0.165,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: const Color.fromARGB(255, 213, 213, 213)),
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: width * 0.6,
                                          height: height * 0.16,
                                          
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              if(snapshot.data!.docs[index]['ItemType'] == 'Veg')
                                                Image.asset('assets/icons/veg.png',width: 25,),
                                              if(snapshot.data!.docs[index]['ItemType'] == 'Non-Veg')
                                                Image.asset('assets/icons/nonveg.png',width: 25,),
                                              const SizedBox(height: 1,),
                                              Text(snapshot.data!.docs[index]['ItemName'],style:const TextStyle(fontSize: 20,fontFamily: 'sen',fontWeight: FontWeight.bold),),
                                              Text(snapshot.data!.docs[index]['ItemPrice']+".00",style: const TextStyle(fontSize: 16,fontFamily: 'sen'),),
                                              Text(snapshot.data!.docs[index]['ItemDescription'],style:const TextStyle(fontSize:10,fontFamily: 'sen'),overflow: TextOverflow.ellipsis,maxLines: 3,),
                                            ],
                                          ),
                                        ),
                                      const SizedBox(width: 10,),
                                      Container(
                                        width: width * 0.27,
                                        height: height * 0.14,
                                        child: CachedNetworkImage(
                                          imageUrl: snapshot.data!.docs[index]['ItemImage'],
                                          imageBuilder: (context, imageProvider) => 
                                            Container(
                                              height: height * 0.14,
                                              width: width * 0.27,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                )
                                              ),
                                            ),
                                            placeholder: (context, url) => 
                                              Container(
                                                alignment: Alignment.center,
                                                child: LoadingAnimationWidget.fourRotatingDots(color: Colors.grey, size: 10),
                                              ),
                                            errorWidget: (context, url, error) => 
                                              Image(image: AssetImage('assets/icons/errorDish.png')),
                                          ),
                                        ),
                                    ],
                                  ),
                                )
                              )
                            ],
                          ),
                        );
                      },
                      );
                    }
                    return Container();
                      
                    },
                  )
                )
              ],
            ),
            Positioned(
              right: width * 0.045,
              bottom: height * 0.11,
              child: GestureDetector(
                child: Container(
                  width: width * 0.4,
                  height: height * 0.05,
                  decoration:const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: const Color.fromARGB(255, 247, 200, 255)
                  ),
                  child:const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.photo_album_rounded),
                        SizedBox(width: 5,),
                        Text("Add Images",style: TextStyle(fontFamily: 'sen',fontSize: 15),),
                      ],
                    ),
                  )
                ),
                onTap: (){
                  Get.to(AddImages());
                },
              ),
            )
            ]
          )
        ),
      ),
    );
  }
}


//NetworkImage(snapshot.data!.docs[index]['ItemImage']),

/*Widget MenuItems(MenuItemController controller)async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return StreamBuilder(
    stream:controller.menuItemStream,
    builder: (context , AsyncSnapshot<QuerySnapshot> snapshot){
      if(snapshot.hasError){
        return const Text("Something is Wrong");
      }
      if(snapshot.connectionState == ConnectionState.waiting){
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      }
      if(snapshot.data!.docs.isEmpty){
        return const Text("No Data Found");
      }
      if(snapshot != null && snapshot.data != null){
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius:const BorderRadius.all(Radius.circular(12)),
                      image: DecorationImage(
                        image: NetworkImage(snapshot.data!.docs[index]['ItemImage']),
                      )
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Column(
                    children: [
                      Text(snapshot.data!.docs[index]['ItemName'],style:const TextStyle(color: Colors.black),)
                    ],
                  )
                ],
              ),
            );
          },
        );
      }
      return Container();
    },
  );
}*/