import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compra/consts/consts.dart';
import 'package:compra/consts/lists.dart';
import 'package:compra/controller/product_controller.dart';
import 'package:compra/services/firestore_services.dart';
import 'package:compra/views/cart_screen/cart_screen.dart';
import 'package:compra/views/chat_screen/chat_screen.dart';
import 'package:compra/widgets_common/loading_indicator.dart';
import 'package:compra/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemDetails extends StatelessWidget {
  final String? title; //PRODUCT TITLE
  final dynamic data;
  const ItemDetails({super.key, required this.title, this.data});

  @override
  Widget build(BuildContext context) {
    var controller  = Get.put(ProductController());
    Get.put(ProductController());

    return WillPopScope(
      onWillPop: () async {
        await controller.resetValues(double.parse(data['p_price']));
        return true;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          leading: IconButton(onPressed: () async {
            await controller.resetValues(double.parse(data['p_price']));
            Get.back();
            //ARROW BACK
          }, icon: const Icon(Icons.arrow_back)),
          title: title!.text.capitalize.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            Obx( //ADD TO WISHLIST/ REMOVE TO WISHLIST
              () => IconButton(onPressed: (){
                if (controller.isFav.value) {
                  controller.removeFromWishlist(data.id,context);
                } else {
                  controller.addToWishlist(data.id,context);
                }
              }, icon: Icon(Icons.favorite_outlined, color: controller.isFav.value ? redColor: darkFontGrey)),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //swiper section
    
                      VxSwiper.builder(
                        autoPlay: true,
                        height: 350,
                        itemCount: data['p_imgs'].length, 
                        aspectRatio: 16 /9,
                        viewportFraction: 1.0,
                        itemBuilder: (context, index){
                          return Image.network(
                            data["p_imgs"][index], 
                            width: double.infinity, 
                            fit: BoxFit.cover,
                          );
                        }),
    
                        10.heightBox,
                        //title and details section
                        title!.text.capitalize.size(16).color(darkFontGrey).fontFamily(semibold).make(),
    
                        10.heightBox,
                        //PRICE
                        10.heightBox,
                        "${data['p_price']}".numCurrency.text.color(Color.fromRGBO(4, 84, 158, 30),).fontFamily(bold).size(18).make(),
                                        
                        20.heightBox,
                        Obx(
                          () => Column(
                            children: [

                              //QUANTITY ROW
                              Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: "Quantity: ".text.color(textfieldGrey).make(),
                                  ),
                                  Obx(
                                    () => Row(
                                      children: [
                                        IconButton(onPressed: (){
                                          controller.decreaseQuantity();
                                          controller.calculateTotalPrice(double.parse(data['p_price']));
                                        }, icon: const Icon(Icons.remove)),
                                        controller.quantity.value.text.size(16).color(darkFontGrey).fontFamily(bold).make(),
                                        IconButton(onPressed: (){
                                          controller.increaseQuantity(int.parse(data['p_quantity']));
                                          controller.calculateTotalPrice(double.parse(data['p_price']));
                                        }, icon: const Icon(Icons.add)),
                                        10.widthBox,
                                        "(${data['p_quantity']} available)".text.color(textfieldGrey).make(),
                                      ],
                                    ),
                                  ),
                                ],
                              ).box.padding(const EdgeInsets.all(8)).make(),
                        
                        
                        
                              //TOTAL
                              Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: "Total: ".text.color(textfieldGrey).make(),
                                  ),
                                  "${controller.totalPrice.value}".numCurrency.text.color(const Color.fromRGBO(4, 83, 158, 30),).size(16).fontFamily(bold).make(),
                                ],
                              ).box.padding(const EdgeInsets.all(8)).make(),
                        
                        
                            ],
                          ).box.white.shadowSm.make(),
                        ),
    
                         //DESCRIPTION 
                          10.heightBox,
                          "Description".text.color(darkFontGrey).fontFamily(semibold).make(),
                          10.heightBox,
                          "${data['p_desc']}".text.color(darkFontGrey).make(),
    
                          10.heightBox,

                          //PRODUCTS YOU MAY ALSO LIKE
                          20.heightBox,
                          productsyoumaylike.text.fontFamily(bold).size(16).color(darkFontGrey).make(),
                          10.heightBox,

                          
                          // i copied this widget from home screen featured products
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

                                  var featureData = snapshot.data!.docs;

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
                                      Navigator.push(context,MaterialPageRoute(builder: (context) =>
                                        ItemDetails(
                                          title: "${featureData[index]['p_name']}",
                                          data: featureData[index],
                                        )
                                      
                                      ));
                                    })),
                                  );
                                }
                              }
                            ),
                          ),
                    ],
                  ),
                ),
              )
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ourButton(
                color: const Color.fromRGBO(4, 83, 158, 30), 
                onPress: (){
                  if (controller.quantity.value > 0) {
                    controller.addToCart(
                      // color: data['p_colors'][controller.colorIndex.value],
                      context: context,
                      vendorID: data['vendor_id'],
                      img: data['p_imgs'][0],
                      qty: controller.quantity.value,
                      sellername: data['p_seller'],
                      title: data['p_name'],
                      product_id: data['document_id'],
                      tprice: controller.totalPrice.value
                    );
                    VxToast.show(context, msg: "Added to cart");
                  } else {
                    VxToast.show(context, msg: "Minimum of 1 quantity is required");   
                  }
                },
                textColor: Color.fromARGB(255,254, 240, 2), //ADD TO CART
                title: "Add to cart",
              ),
            ),
          ],
        ),
      ),
    );
  }
}