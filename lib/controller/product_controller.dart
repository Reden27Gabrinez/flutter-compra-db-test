import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compra/consts/consts.dart';
import 'package:compra/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{

  var quantity = 1.obs;
  var totalPrice = 0.0.obs; // Change the type to double
  

 var isFav = false.obs;

//function to pass the price to item details as total price in default
void passItemPrice({required String priceItem}) {
    // Assuming priceItem is a string representation of a numerical value
    // You might want to convert it to a numeric type before updating totalPrice
    double numericPrice = double.parse(priceItem);
    
    // Update the totalPrice variable
    totalPrice.value = numericPrice;

    // Optionally, you can print the updated totalPrice
    print("Updated totalPrice: ${totalPrice.value}");
  }



  var subcat = [];

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//SUBCAT
  getSubCategories(title) async {
    // subcat.clear();
    QuerySnapshot querySnapshot = await _firestore
      .collection('category')
      .where('name', isEqualTo: title)
      .get();

    if (querySnapshot.docs.isNotEmpty) {
      subcat = List<String>.from(querySnapshot.docs.first['categories']);
    }
    print(subcat);

    return subcat;
  }

  increaseQuantity(totalQuantity)
  {
    if (quantity.value < totalQuantity) {
      quantity.value++;
    }
  }

  decreaseQuantity()
  {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  calculateTotalPrice(price)
  {
    totalPrice.value = price * quantity.value.toDouble();
  }

  addToCart({
  title,
  img,
  sellername,
  color,
  qty,
  tprice,
  context,
  vendorID,
  product_id
}) async {
  // Define the cart item data
  final cartItemData = {
    'title': title,
    'img': img,
    'sellername': sellername,
    'qty': qty,
    'vendor_id': vendorID,
    'tprice': tprice,
    'added_by': currentUser!.uid,
    'product_id': product_id,
  };

  // Check if a similar product already exists in the cart
  final QuerySnapshot existingProducts = await firestore
      .collection(cartCollection)
      .where('title', isEqualTo: title)
      .where('sellername', isEqualTo: sellername)
      .where('vendor_id', isEqualTo: vendorID)
      .where('added_by', isEqualTo: currentUser!.uid)
      .where('product_id', isEqualTo: product_id)
      .get();

  // If similar product exists, update the quantity
  if (existingProducts.docs.isNotEmpty) {
    final docId = existingProducts.docs.first.id;
    final existingQty = existingProducts.docs.first['qty'] ?? 0;
    final newQty = existingQty + qty;

    final existingtprice = existingProducts.docs.first['tprice'] ?? 0;
    final newtprice = existingtprice + tprice;

    await firestore.collection(cartCollection).doc(docId).update({
      'qty': newQty,
      'tprice': newtprice,
    });
  } else {
    // If not, add a new document to the cart
    await firestore.collection(cartCollection).doc().set(cartItemData);
  }
}


  resetValues(price)
  {
    totalPrice.value = price.toDouble();
    quantity.value = 1;
    isFav.value = false;
  }

  addToWishlist(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: "Added to wishlist");
  }

  removeFromWishlist(docId, context) async
  {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(false);
    VxToast.show(context, msg: "Removed from wishlist");
  }

  checkIfFav(data) async{
    if(data['p_wishlist'].contains(currentUser!.uid))
    {
      isFav(true);
    }
    else
    {
      isFav(false);
    }
  }
  

}