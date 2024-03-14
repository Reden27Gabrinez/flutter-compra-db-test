import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compra/consts/consts.dart';
import 'package:compra/controller/product_controller.dart';
import 'package:compra/services/firestore_services.dart';
import 'package:compra/views/category_screen/item_details.dart';
import 'package:compra/widgets_common/loading_indicator.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  final String? title;
  const SearchScreen({Key? key, this.title}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var controller = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: widget.title!.text.color(darkFontGrey).make(),
      ),
      body: FutureBuilder(
        future:FirestoreServices.searchProducts(widget.title),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: loadingIndicator(),);
          } else if(snapshot.data!.docs.isEmpty) {
            return "No products found".text.makeCentered();
          }else{
            var data = snapshot.data!.docs;
            var filtered = data.where((element) => element['p_name'].toString().toLowerCase().contains(widget.title!.toLowerCase()),)
            .toList();   


            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, 
                                mainAxisSpacing: 8, 
                                crossAxisSpacing: 8,
                                mainAxisExtent: 300
                              ), 
                children: filtered.mapIndexed((currentValue, index) =>Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        filtered[index]['p_imgs'][0], 
                                        height: 200,
                                        width: 200,
                                        fit: BoxFit.cover,
                                      ),
                                      const Spacer(),
                                      "${filtered[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                                      10.heightBox,
                                      //////////////////////////////////////////////////////////////////////////////.
                                      "${filtered[index]['p_price']}".numCurrency.text.color(Color.fromRGBO(4, 84, 158, 30),).fontFamily(bold).size(16).make(),
                                    ],
                                  ).box.white.outerShadowMd.margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(const EdgeInsets.all(12)).make().onTap(() {
                                    Get.to(() =>ItemDetails(
                                      title: "${filtered[index]['p_name']}",
                                      data: filtered[index],
                                    ));
                                    //item details pass the item price to total price as default
                                    controller.passItemPrice(priceItem: "${filtered[index]['p_price']}");
                                  })
                                  ).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}