import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compra/consts/consts.dart';
import 'package:compra/controller/home_controller.dart';
import 'package:get/get.dart';
import 'dart:math';

class CartController extends GetxController
{
  var totlalP = 0.0.obs; // Change the type to double

  //text controllers for shipping details
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  // var stateController = TextEditingController();/
  // var postalcodeController = TextEditingController();
  var phoneController = TextEditingController();


  var paymentIndex = 0.obs;

  late dynamic productSnapshot;
  var products = [];

  var placingOrder = false.obs;



  calculate(data)
  {
    totlalP.value = 0.0;
    for(var i=0; i < data.length; i++)
    {
      totlalP.value = totlalP.value + double.parse(data[i]['tprice'].toString());
    }
  }

  changePaymentIndex(index)
  {
    paymentIndex.value = index;
  }



  placeMyOrder({required orderPaymentMethod, required totalAmount}) async {
  placingOrder(true);
  await getProductDetails();

  int MAX = 100000000;
  var ran = Random().nextInt(MAX) + 100;
  String stringValue = ran.toString();

  // Update the product quantities and place the order
  await updateProductQuantities();

  await FirebaseFirestore.instance.collection(ordersCollection).add({
    'order_code': stringValue,
    'order_date': FieldValue.serverTimestamp(),
    'order_by': currentUser!.uid,
    'order_by_name': Get.find<HomeController>().username,
    'order_by_email': currentUser!.email,
    'order_by_address': addressController.text,
    'order_by_city': "Oroquieta City",
    'order_by_phone': phoneController.text,
    'payment_method': orderPaymentMethod,
    'order_placed': true,
    'order_confirmed': false,
    'order_delivered': false,
    'order_on_delivery': false,
    'total_amount': totalAmount,
    'orders': FieldValue.arrayUnion(products)
  });
  placingOrder(false);
}

// Add a new function to update product quantities
updateProductQuantities() async {
  for (var product in products) {
    String productId = product['product_id'];
    int quantity = product['qty'];

    print(productId);

    // Fetch the current product document from Firestore
    DocumentSnapshot productDoc =
        await FirebaseFirestore.instance.collection(productsCollection).doc(productId).get();

    // print(productDoc['p_quantity']);

    if (productDoc.exists) {
      // int currentQuantity = productDoc['p_quantity'];
      String curQuantity = productDoc['p_quantity']; // Assuming 'p_quantity' contains a numeric string
      int currentQuantity = int.parse(curQuantity);
      int sub = currentQuantity - quantity;
      String minussedQuantity = sub.toString();


      print(minussedQuantity);

      if (currentQuantity >= quantity) {
        // Subtract the ordered quantity from the current quantity
        await FirebaseFirestore.instance.collection(productsCollection).doc(productId).update({
          'p_quantity': minussedQuantity,
        });
      } else {
        // Handle the case where the ordered quantity is more than the available quantity
        print('Not enough quantity available for product: $productId');
        // You may want to return an error or handle this case appropriately
      }
    }
    else
    {
      print('productdoc not exist');
    }
  }
}

getProductDetails() {
  products.clear();
  for (var i = 0; i < productSnapshot.length; i++) {
    products.add({
      // 'document_id': productSnapshot[i]['document_id'],
      'img': productSnapshot[i]['img'],
      'vendor_id': productSnapshot[i]['vendor_id'],
      'tprice': productSnapshot[i]['tprice'],
      'qty': productSnapshot[i]['qty'],
      'title': productSnapshot[i]['title'],
      'product_id': productSnapshot[i]['product_id'],
    });
  }
}


  // placeMyOrder({required orderPaymentMethod, required totalAmount}) async {
  //   placingOrder(true);
  //   await getProductDetails();

  //     int MAX = 100000000;
  //     var ran = Random().nextInt(MAX) + 100;
  //     String stringValue = ran.toString();

  //     // Update the product quantities and place the order
  //   await updateProductQuantities();

  //   await firestore.collection(ordersCollection).doc().set({
  //     'order_code': stringValue,
  //     'order_date': FieldValue.serverTimestamp(),
  //     'order_by': currentUser!.uid,
  //     'order_by_name': Get.find<HomeController>().username,
  //     'order_by_email': currentUser!.email,
  //     'order_by_address': addressController.text,
  //     // 'order_by_state': stateController.text,
  //     'order_by_city': "Oroquieta City",
  //     'order_by_phone': phoneController.text,
  //     // 'order_by_postalcode': "7207",
  //     // 'shipping_method': "Home Delivery",
  //     'payment_method': orderPaymentMethod,
  //     'order_placed': true,
  //     'order_confirmed': false,
  //     'order_delivered': false,
  //     'order_on_delivery': false,
  //     'total_amount': totalAmount,
  //     // 'status': "Approve",
  //     'orders': FieldValue.arrayUnion(products)
  //   });
  //   placingOrder(false);
  // }


  // // // Add a new function to update product quantities
  // updateProductQuantities() async {
  //   for (var product in products) {
  //     String productId = product['document_id'];
  //     int quantity = product['qty'];
      
  //     // Fetch the current product document from Firestore
  //     DocumentSnapshot productDoc = await firestore.collection(productsCollection).doc(productId).get();

  //     if (productDoc.exists) {
  //       int currentQuantity = productDoc['p_quantity'];
  //       print(currentQuantity);
        
  //       if (currentQuantity >= quantity) {
  //         // Subtract the ordered quantity from the current quantity
  //         await firestore.collection(productsCollection).doc(productId).update({
  //           'p_quantity': currentQuantity - quantity,
  //         });
  //       }
  //     }
  //   }
  // }

  // getProductDetails()
  // {
  //   products.clear();
  //   for(var i = 0; i < productSnapshot.length; i++)
  //   {
  //     products.add({
  //       // 'color': productSnapshot[i]['color'],
  //       'img': productSnapshot[i]['img'],
  //       'vendor_id': productSnapshot[i]['vendor_id'],
  //       'tprice': productSnapshot[i]['tprice'],
  //       'qty': productSnapshot[i]['qty'],
  //       'title': productSnapshot[i]['title'],
  //       'prod_id': productSnapshot[i]['product_id'],
  //     });
  //   }
  // }


  clearCart()
  {
    for(var i=0; i < productSnapshot.length; i++)
    {
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }



}