import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compra/consts/consts.dart';
import 'package:compra/controller/cart_controller.dart';
import 'package:compra/services/firestore_services.dart';
import 'package:compra/views/cart_screen/shipping_screen.dart';
import 'package:compra/widgets_common/loading_indicator.dart';
import 'package:compra/widgets_common/our_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(CartController());

    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: SizedBox(
                            height: 60,
                            width: context.screenWidth - 60,
                            child: ourButton(
                              color: const Color.fromRGBO(4, 83, 158, 30), 
                              onPress: () {
                                Get.to(()=> const ShippingDetails());
                              },
                              textColor:  Color.fromARGB(255,254, 240, 2),
                              title: "Proceed to Delivery",
                          ),
                        ),
        //SHOPPING CART appbar 
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Shopping cart".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),

      body: StreamBuilder(
        stream: FirestoreServices.getCart(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snaphsot) {
          if (!snaphsot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          }
          else if(snaphsot.data!.docs.isEmpty)
          {
            return Center(
              child: "Cart is empty".text.color(darkFontGrey).make(),
            );
          }
          else
          {
            var data = snaphsot.data!.docs;
            controller.calculate(data);
            controller.productSnapshot = data;
            
            return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: Image.network("${data[index]['img']}", width: 90, fit: BoxFit.cover,),
                                title: "${data[index]['title']} (x${data[index]['qty']})".text.fontFamily(semibold).size(16).make(),
                                subtitle: "${data[index]['tprice']}".numCurrency.text.color(Color.fromRGBO(4, 84, 158, 30),).fontFamily(semibold).make(),
                                trailing: const Icon(
                                  Icons.delete,
                                  color: redColor,
                                ).onTap(() { 
                                  FirestoreServices.deleteDocument(data[index].id);
                                }),
                              );
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "Total Price".text.fontFamily(bold).color(Color.fromARGB(255,254, 240, 2),).make(),
                            Obx(
                              () => "${controller.totlalP.value}".
                                numCurrency.text.
                                fontFamily(bold).
                                color(Color.fromARGB(255,254, 240, 2),).make(),
                            ),
                          ], 
                        ).box.padding(EdgeInsets.all(12)).color(Color.fromRGBO(4, 83, 158, 30),).width(context.screenWidth - 60).roundedSM.make(),

                        10.heightBox,
                        // SizedBox(
                        //   width: context.screenWidth - 60,
                        //   child: ourButton(
                        //     color: redColor,
                        //     onPress: () {},
                        //     textColor: whiteColor,
                        //     title: "Proceed to Shipping",
                        //   ),
                        // ),


                      ],
                    ),
                  );
          }
        },
      ),
    );
  }
}