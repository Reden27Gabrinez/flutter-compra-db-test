import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compra/consts/consts.dart';
import 'package:compra/consts/lists.dart';
import 'package:compra/controller/home_controller.dart';
import 'package:compra/controller/product_controller.dart';
import 'package:compra/services/firestore_services.dart';
import 'package:compra/views/auth_screen/login_screen.dart';
import 'package:compra/views/category_screen/category_details.dart';

import 'package:compra/views/category_screen/item_details.dart';
import 'package:compra/views/home_screen/components/featured_button.dart';
import 'package:compra/views/home_screen/search_screen.dart';
import 'package:compra/widgets_common/bg_widget.dart';
import 'package:compra/widgets_common/home_buttons.dart';
import 'package:compra/widgets_common/loading_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_fcm/flutter_fcm.dart';
import 'package:get/get.dart';

import '../../services/notif_service.dart';

class HomeScreen extends StatefulWidget {
  // const HomeScreen({super.key});
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//NOTIFICATION
  static final notifications = NotificationService();

  @override
  void initState() {
    notifications.requestPermission();
    notifications.firebaseNotification(context);

    // FirebaseMessaging.instance.getToken().then((token) => FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
    //   'user-token': token,
    // }));
    FirebaseMessaging.instance.getToken().then((token) {
      if (FirebaseAuth.instance.currentUser != null) {
        FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
          'user-token': token,
        });
      }
      else
      {
        Get.offAll(() => LoginScreen());    
      }
    });


    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
  var controller = Get.find<HomeController>();
  Get.put(ProductController());

  var controller2 = Get.put(ProductController());
  



//promos slider
Future<List<String>> getImageURLs() async {
  List<String> imageUrls = [];

  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('promos').get();

  querySnapshot.docs.forEach((doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    if (data.containsKey('current_promos') && data['current_promos'] is List) {
      List<dynamic> currentPromos = data['current_promos'];
      for (var promo in currentPromos) {
        if (promo is String) {
          imageUrls.add(promo);
        }
      }
    }
  });

  return imageUrls;
}

    return bgWidget(
      child: Container(
        padding: const EdgeInsets.all(12),
        // color: lightGrey,
        width: context.screenWidth,
        height: context.screenHeight,
        child: SafeArea(
          child: Column(
            children: [

              //search bar
              Container(
                alignment: Alignment.center,
                height: 60,
                // color: lightGrey,
                child: TextFormField(
                  controller: controller.searchController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: const Icon(Icons.search).onTap(() {
                      if(controller.searchController.text.isNotEmptyAndNotNull)
                      {
                        Get.to(()=> SearchScreen(
                          title: controller.searchController.text,
                        ));
                      }
                    }),
                    filled: true,
                    fillColor: whiteColor,
                    hintText: searchanything,
                    hintStyle: const TextStyle(color: textfieldGrey)
                  ),
                ).box.shadowSm.make(),
              ),
              //search bar taman diri
   
    //Para maglihok lihok
              10.heightBox,
    
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [



                      // swiper db promos
                      FutureBuilder<List<String>>(
                        future: getImageURLs(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return loadingIndicator();
                          } else if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          } else if (snapshot.hasData) {
                            List<String>? imageUrls = snapshot.data;
                            return VxSwiper.builder(
                              aspectRatio: 16 / 9,
                              autoPlay: true,
                              height: 150,
                              enlargeCenterPage: true,
                              itemCount: imageUrls!.length,
                              itemBuilder: (context, index) {
                                return Image.network(
                                  imageUrls[index],
                                  fit: BoxFit.fill,
                                ).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make();
                              },
                            );
                          } else {
                            return Container(); // Handle other cases as needed
                          }
                        },
                      ),
                      // swiper db








                      //Swiper brands
                      // VxSwiper.builder(
                      //   aspectRatio: 16 / 9,
                      //   autoPlay: true,
                      //   height: 150,
                      //   enlargeCenterPage: true,
                      //   itemCount: slidersList.length, 
                      //   itemBuilder: (context, index)
                      //   {
                      //     return Image.asset(
                      //       slidersList[index],
                      //       fit: BoxFit.fill,
                      //     ).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make();
                      //   }
                      // ),
                
                      // 15.heightBox,
                      // //deals button
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: List.generate(2, (index) => homeButtons(
                      //     height: context.screenHeight * 0.15,
                      //     width: context.screenWidth / 2.5,
                      //     icon: index == 0 ? icTodaysDeal : icFlashDeal,
                      //     title: index == 0 ? todayDeal : flashsale,
                      //   )),
                      // ),
                
                      //2nd swiper
                      // 15.heightBox,
                      // //Swiper brands
                      // VxSwiper.builder(
                      //   aspectRatio: 16 / 9,
                      //   autoPlay: true,
                      //   height: 150,
                      //   enlargeCenterPage: true,
                      //   itemCount: secondSlidersList.length, 
                      //   itemBuilder: (context, index)
                      //   {
                      //     return Image.asset(
                      //       secondSlidersList[index],
                      //       fit: BoxFit.fill,
                      //     ).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make();
                      //   }
                      // ),
                
                
                      //category buttons
                      // 15.heightBox,
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: List.generate(3, (index) => homeButtons(
                      //     height: context.screenHeight * 0.15,
                      //     width: context.screenWidth / 3.5,
                      //     icon:  index == 0 ? icTopCategories : index == 1 ? icBrands : icTopSeller,
                      //     title: index == 0 ? topCategories : index == 1 ? brand : topSellers,
                
                      //   )),
                      // ),
                


                      // Featured categories
                      20.heightBox,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: featuredCategories.text.color(whiteColor).size(18).fontFamily(semibold).make(),
                      ),
                      10.heightBox,
                      // SingleChildScrollView(
                      //   scrollDirection: Axis.horizontal,
                      //   child: Row(
                      //     children: List.generate(3, (index) => Column(
                      //       children: [
                      //         featuredButton(icon: featuredImages1[index], title: featuredTitles1[index]),
                      //         10.heightBox,
                      //         featuredButton(icon: featuredImages2[index], title: featuredTitles2[index]),
                      //       ],
                      //     )),
                      //   ),
                      // ),


                      // StreamBuilder<QuerySnapshot>(
                      //   stream: FirebaseFirestore.instance.collection('category').where('name', isEqualTo: 'personal care').snapshots(),
                      //   builder: (context, snapshot) {
                      //     if (!snapshot.hasData) {
                      //       return Center(
                      //         child: loadingIndicator(),
                      //       );
                      //     }

                      //     final categories = snapshot.data!.docs;


                      //     // Limiting to the first 5 items
                      //     // var categories = limitedFeatureData.take(5).toList();

                      //     return SingleChildScrollView(
                      //       scrollDirection: Axis.horizontal,
                      //       child: Row(
                      //         children: List.generate(categories.length, (index) {
                      //           final category = categories[index];
                      //           final categoryName = category['name'];

                      //           return Column(
                      //             children: [
                      //               10.heightBox,
                      //               Padding(
                      //                 padding: const EdgeInsets.all(12.0),
                      //                 child: Text(
                      //                   categoryName.substring(0, 1).toUpperCase() + categoryName.substring(1),
                      //                   style: TextStyle(
                      //                     color: Colors.black,
                      //                     fontSize: 16,
                      //                     fontWeight: FontWeight.bold,
                      //                   ),
                      //                   textAlign: TextAlign.center,
                      //                 ),
                      //               ),
                      //             ],
                      //           ).box.white
                      //               .rounded
                      //               .clip(Clip.antiAlias)
                      //               .outerShadowSm
                      //               .make()
                      //               .onTap(() async {
                      //                 await controller2.getSubCategories(categoryName);
                      //                 await Get.to(() => CategoryDetails(title: categoryName));
                      //               }).box.width(200).margin(const EdgeInsets.symmetric(horizontal: 4)).white.padding(const EdgeInsets.all(4)).roundedSM.outerShadowSm.make();
                      //         }),
                      //       ),
                      //     );
                      //   },
                      // ),


                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection('category').snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: loadingIndicator(),
                            );
                          }

                          // final limitedFeatureData = snapshot.data!.docs;


                          // // Limiting to the first 5 items
                          // var categories = limitedFeatureData.take(5).toList();



                          final allCategories = snapshot.data!.docs;

                          // Shuffle the categories
                          var random = Random();
                          var shuffledCategories = List.from(allCategories);
                          shuffledCategories.shuffle();

                          // Limiting to the first 5 shuffled items
                          var categories = shuffledCategories.take(5).toList();

                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(categories.length, (index) {
                                final category = categories[index];
                                final categoryName = category['name'];

                                return Column(
                                  children: [
                                    10.heightBox,
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        categoryName.substring(0, 1).toUpperCase() + categoryName.substring(1),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ).box.color(Color.fromARGB(255,254, 240, 2))
                                    .rounded
                                    .clip(Clip.antiAlias)
                                    .outerShadowSm
                                    .make()
                                    .onTap(() async {
                                      await controller2.getSubCategories(categoryName);
                                      await Get.to(() => CategoryDetails(title: categoryName));
                                    }).box.width(200).margin(const EdgeInsets.symmetric(horizontal: 4)).white.padding(const EdgeInsets.all(4)).roundedSM.outerShadowSm.make();
                              }),
                            ),
                          );
                        },
                      ),

    
    
    
                      //featured product
                      20.heightBox,
                      Container(
                        padding: const EdgeInsets.all(12),
                        width: double.infinity,
                        decoration: const BoxDecoration(color: Color.fromARGB(255,254, 240, 2)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            featuredProduct.text.color(Color.fromRGBO(4, 84, 158, 30),).fontFamily(bold).size(18).make(),
                            10.heightBox,
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: FutureBuilder(
                                future: FirestoreServices.getFeaturedProducts(),
                                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if(!snapshot.hasData)
                                  {
                                    return Center(
                                      child: loadingIndicator(),
                                    );
                                  }
                                  else if(snapshot.data!.docs.isEmpty)
                                  {
                                    return "No featured products".text.white.makeCentered();
                                  }
                                  else
                                  {
    
                                    var limitedFeatureData = snapshot.data!.docs;

                                    // Limiting to the first 5 items (Featured Products)
                                    var featureData = limitedFeatureData.take(5).toList();
    
                                    return Row(
                                      children: List.generate(featureData.length, (index) => Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            featureData[index]['p_imgs'][0], 
                                            width: 130,
                                            height: 130,
                                            fit: BoxFit.cover,
                                          ),
                                          10.heightBox,
                                          "${featureData[index]['p_name']}".text.fontFamily(semibold).make(),
                                          10.heightBox,
                                          //////////////////////////////////////////////////////////////////////////////.
                                          "${featureData[index]['p_price']}".numCurrency.text.color(Color.fromRGBO(4, 84, 158, 30),).fontFamily(bold).size(16).make(),
                                        ],
                                      ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(const EdgeInsets.all(8)).make().onTap(() {
                                        Get.to(() =>ItemDetails(
                                          title: "${featureData[index]['p_name']}",
                                          data: featureData[index],
                                        ));
                                        //item details pass the item price to total price as default
                                        controller2.passItemPrice(priceItem: "${featureData[index]['p_price']}");
                                      })),
                                    );
                                  }
                                }
                              ),
                            ),
                          ],
                        ),
                      ),
    
    
                      //2nd swiper
                      20.heightBox,
                      VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 150,
                        enlargeCenterPage: true,
                        itemCount: secondSlidersList.length, 
                        itemBuilder: (context, index)
                        {
                          return Image.asset(
                            secondSlidersList[index],
                            fit: BoxFit.fill,
                          ).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make();
                        }
                      ),



                    
    
                      //ALL PRODUCTS SECTION
                      20.heightBox,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: "All Products".text.fontFamily(bold).color(whiteColor).size(18).make(),
                      ),
                      20.heightBox,
                      StreamBuilder(
                        stream: FirestoreServices.allproducts(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
                        {
                          if(!snapshot.hasData)
                          {
                            return loadingIndicator();
                          }
                          else
                          {

                            final shuffledProducts = snapshot.data!.docs;

                            //Shuffled producsts
                            var random = Random();
                            var allproductsdata = List.from(shuffledProducts);
                            allproductsdata.shuffle();
                            //Shuffled producsts

                            return GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: allproductsdata.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, 
                                mainAxisSpacing: 8, 
                                crossAxisSpacing: 8,
                                mainAxisExtent: 300
                              ), 
                              itemBuilder: (context,index)
                              {
                                return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        allproductsdata[index]['p_imgs'][0], 
                                        height: 200,
                                        width: 200,
                                        fit: BoxFit.cover,
                                      ),
                                      const Spacer(),
                                      "${allproductsdata[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                                      10.heightBox,
                                      //////////////////////////////////////////////////////////////////////////////.
                                      "${allproductsdata[index]['p_price']}".numCurrency.text.color(Color.fromRGBO(4, 84, 158, 30),).fontFamily(bold).size(16).make(),
                                    ],
                                ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(const EdgeInsets.all(12)).make().onTap(() {
                                  Get.to(() =>ItemDetails(
                                    title: "${allproductsdata[index]['p_name']}",
                                    data: allproductsdata[index],
                                  ));
                                  //item details pass the item price to total price as default
                                  controller2.passItemPrice(priceItem: "${allproductsdata[index]['p_price']}");
                                });
                              },
                            );
                          }
                        }
                      ),
    
    
                    ],
                  ),
                ),
              ),
    
    
            ],
          ),
        ),
      ),
    );
  }
}