import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compra/consts/consts.dart';
import 'package:compra/services/firestore_services.dart';
import 'package:compra/views/orders_screen/orders_details.dart';
import 'package:compra/widgets_common/loading_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Orders".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllOrders(),

        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData)
          {
            return Center(child: loadingIndicator(),);
          }
          else if(snapshot.data!.docs.isEmpty)
          {
            return "No orders yet!".text.color(darkFontGrey).makeCentered();
          }
          else
          {


            var data = snapshot.data!.docs;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile( 
                    // leading: "${index +1}".text.fontFamily(bold).color(Colors.black).xl.make(), ///numbering 
                    title: data[index]['order_code'].toString().text.color(Color.fromRGBO(4, 84, 158, 30)).fontFamily(semibold).make().onTap(() {
                      Get.to(() =>  OrdersDetails(data:data[index]));
                    }),
                    subtitle: data[index]['total_amount'].toString().numCurrency.text.fontFamily(bold).make().onTap(() {
                      Get.to(() =>  OrdersDetails(data:data[index]));
                    }),
                    trailing: Wrap(
                      spacing: 12,
                      children: <Widget>[
                            IconButton(
                                  onPressed: () async {
                             
                              // Show a success message (you can use a snackbar or another dialog)
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Cancel Order"),
                                      content: Text("Are you sure you want to cancel this order?"),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text("No",style: TextStyle(color: Color.fromRGBO(4, 84, 158, 30)),),
                                          onPressed: () {
                                            Navigator.of(context).pop(); // Close the dialog
                                          },
                                        ),
                                        TextButton(
                                          child: Text("Yes", style: TextStyle(color: Color.fromRGBO(4, 84, 158, 30))),
                                          onPressed: () {
                                            // Check if the order has been placed
                                            bool orderplaced = data[index]['order_placed'];
                                            bool orderdelivered = data[index]['order_delivered'];
                                            bool orderconfirmed = data[index]['order_confirmed'];
                                            bool orderon_delivery = data[index]['order_on_delivery'];

                                            if (orderplaced == true) {
                                              // Perform the cancellation logic here
                                              FirestoreServices.deleteDocument2(data[index].id);
                                              Navigator.of(context).pop(); // Close the dialog
                                            } 
                                            else {
                                              if (orderconfirmed == true) 
                                              {
                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                  content: Text("This order has already been confirmed and cannot be canceled."),
                                                  duration: Duration(seconds: 3),
                                                ));
                                              } 
                                              else if(orderon_delivery == true)
                                              {
                                                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                  content: Text("This order has already been on delivery and cannot be canceled."),
                                                  duration: Duration(seconds: 3),
                                                ));
                                              }
                                              else if(orderdelivered == true)
                                              {
                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                  content: Text("This order has already been delivered and cannot be canceled."),
                                                  duration: Duration(seconds: 3),
                                                ));
                                              }  
                                              else
                                              {
                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                  content: Text("Something happened, Please try again!!"),
                                                  duration: Duration(seconds: 3),
                                                ));
                                              }
                                            }
                                          },
                                        ),
                                      ],
                                                    );
                                },
                              );
                            },
                          icon: const Icon(Icons.cancel_outlined, color: darkFontGrey,),
                        ),
                      ],
                    ),
                  );
                },
            
              ),
            );
          }
        },
      ),
    );
  }
}