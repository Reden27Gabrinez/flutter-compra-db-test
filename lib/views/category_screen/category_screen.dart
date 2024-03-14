import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compra/consts/consts.dart';
import 'package:compra/consts/lists.dart';
import 'package:compra/controller/product_controller.dart';
import 'package:compra/views/category_screen/category_details.dart';
import 'package:compra/widgets_common/bg_widget.dart';
import 'package:compra/widgets_common/loading_indicator.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
   CategoryScreen({super.key});

    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProductController());

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: categories.text.fontFamily(bold).white.make(),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('category').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            }

            final categories = snapshot.data!.docs;
            // Print the categories to the console
            for (var category in categories) {
              print(category['name']);
            }
          return Container(
            padding: EdgeInsets.all(12),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8, mainAxisExtent: 60), 
              itemBuilder: (context,index)
              {
                final category = categories[index];
                final categoryName = category['name'];
                return Column(
                  children: [
                    // Image.asset(
                    //   categoryImages[index],
                    //   height: 120,
                    //   width: 200,
                    //   fit: BoxFit.cover,
                    // ),
                    20.heightBox,
                    // categoryName.text.color(darkFontGrey).align(TextAlign.center).make(),
                    Text(
                      categoryName.substring(0, 1).toUpperCase() + categoryName.substring(1),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ).box.white.rounded.clip(Clip.antiAlias).outerShadowSm.make().onTap(() async {
                  // controller.getSubCategories(categoriesList[index]);
                  // Get.to(() =>CategoryDetails(title: categoriesList[index]));
                  await controller.getSubCategories(categoryName);
                  await Get.to(() => CategoryDetails(title: categoryName));
                  
          
                });
              }
            ),
          );
          }
        ),
      ),
    );
  }
}