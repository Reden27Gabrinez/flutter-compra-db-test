import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compra/controller/product_controller.dart';
import 'package:compra/services/firestore_services.dart';
import 'package:compra/views/category_screen/item_details.dart';
import 'package:compra/widgets_common/bg_widget.dart';
import 'package:compra/widgets_common/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:compra/consts/consts.dart';
import 'package:get/get.dart';


class CategoryDetails extends StatefulWidget {
  final String? title;
  const CategoryDetails({super.key, required this.title});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  switchCategory(title)
  {
    if(controller.subcat.contains(title)){
      productMethod = FirestoreServices.getSubCategoryProducts(title);
    }
    else
    {
      productMethod = FirestoreServices.getProducts(title);
    }
  }

  var controller = Get.find<ProductController>();

  dynamic productMethod;

    @override
  void initState() {
    
    super.initState();
    switchCategory(widget.title);
   
  }


  @override
  Widget build(BuildContext context) {

    

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: widget.title!.text.capitalize.fontFamily(bold).white.make(),
        ),
        body:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(controller.subcat.length, (index) => 
                        "${controller.subcat[index]}".text.size(12).fontFamily(semibold).
                        color(darkFontGrey).
                        makeCentered().box.white.rounded.
                        size(110, 50).margin(EdgeInsets.symmetric(horizontal: 4)).make().onTap(() {
                         switchCategory("${controller.subcat[index]}");
                          setState(() {
                             
                          });
                        })
                        ),
                      ),
                    ),

            20.heightBox,
            StreamBuilder(
              stream: productMethod,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                if(!snapshot.hasData){
                  return Center(
                    child: loadingIndicator(),
                  );
                }
                else if(snapshot.data!.docs.isEmpty)
                {
                  return Expanded(
                    child: "No products found!".text.color(darkFontGrey).makeCentered(),
                  );
                }
                else
                {


                  var data = snapshot.data!.docs;
                  // Print the categories to the console
                  for (var category in data) {
                    print(category['p_name']);
                  }

                  //items container
                  return Expanded(
                    child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 250, mainAxisSpacing: 8, crossAxisSpacing: 8), 
                        itemBuilder: (context,index){
                          return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      
                                      Image.network(
                                        data[index]['p_imgs'][0], 
                                        height: 150,
                                        width: 200,
                                        fit: BoxFit.cover,
                                      ).box.roundedSM.clip(Clip.antiAlias).make(),
                                      const Spacer(),
                                      "${data[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                                      10.heightBox,
                                      //////////////////////////////////////////////////////////////////////////////.
                                      "${data[index]['p_price']}".numCurrency.text.color(Color.fromRGBO(4, 84, 158, 30),).fontFamily(bold).size(16).make(),
                                    ],
                                ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4)).
                                  roundedSM.outerShadowSm.
                                  padding(const EdgeInsets.all(12)).make().
                                  onTap(() {
                                    controller.checkIfFav(data[index]);
                                    Get.to(()=> ItemDetails(title: "${data[index]['p_name']}",data: data[index]));
                                    //item details pass the item price to total price as default
                                    controller.passItemPrice(priceItem: "${data[index]['p_price']}");
                                  });
                        },
                      ));


         


                }
              },
            ),
          ],
        ),
      ),
    );
  }
}