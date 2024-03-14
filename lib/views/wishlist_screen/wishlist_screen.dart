import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compra/consts/consts.dart';
import 'package:compra/controller/product_controller.dart';
import 'package:compra/services/firestore_services.dart';
import 'package:compra/views/category_screen/item_details.dart';
import 'package:compra/widgets_common/loading_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  var controller = Get.find<ProductController>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Wishlist".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getWishlists(),

        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData)
          {
            return Center(child: loadingIndicator(),);
          }
          else if(snapshot.data!.docs.isEmpty)
          {
            return "Wishlist is empty!".text.color(darkFontGrey).makeCentered();
          }
          else
          {
            var data = snapshot.data!.docs;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                                leading: Image.network("${data[index]['p_imgs'][0]}", width: 90, fit: BoxFit.cover,).onTap(() {
                                            Get.to(() =>ItemDetails(
                                              title: "${data[index]['p_name']}",
                                              data: data[index],
                                            ));
                                            //item details pass the item price to total price as default
                                            controller.passItemPrice(priceItem: "${data[index]['p_price']}");
                                          }),
                                title: "${data[index]['p_name']}".text.fontFamily(semibold).size(16).make().onTap(() {
                                            Get.to(() =>ItemDetails(
                                              title: "${data[index]['p_name']}",
                                              data: data[index],
                                            ));
                                            //item details pass the item price to total price as default
                                            controller.passItemPrice(priceItem: "${data[index]['p_price']}");
                                          }),
                                subtitle: "${data[index]['p_price']}".numCurrency.text.color(Color.fromRGBO(4, 84, 158, 30)).fontFamily(semibold).make().onTap(() {
                                            Get.to(() =>ItemDetails(
                                              title: "${data[index]['p_name']}",
                                              data: data[index],
                                            ));
                                            //item details pass the item price to total price as default
                                            controller.passItemPrice(priceItem: "${data[index]['p_price']}");
                                          }),
                                trailing: const Icon(
                                  Icons.favorite,
                                  color: redColor,
                                ).onTap(() async{ 
                                  await firestore.collection(productsCollection).doc(data[index].id).set({
                                    'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
                                  },SetOptions(merge: true));
                                }),
                              );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}