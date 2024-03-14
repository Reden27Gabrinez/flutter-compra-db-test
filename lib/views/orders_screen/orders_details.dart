import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compra/consts/consts.dart';
import 'package:compra/views/orders_screen/components/order_place_details.dart';
import 'package:compra/views/orders_screen/components/order_place_details2.dart';
import 'package:compra/views/orders_screen/components/order_place_details3.dart';
import 'package:compra/views/orders_screen/components/order_status.dart';
import 'package:compra/widgets_common/our_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;
import 'dart:async';

class OrdersDetails extends StatelessWidget {
  final dynamic data;
  const OrdersDetails({Key? key, this.data}) : super(key: key);

 

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: whiteColor,
      // bottomNavigationBar: SizedBox(
      //                       height: 60,
      //                       width: context.screenWidth - 60,
      //                       child: ourButton(
      //                         color: Colors.blue,
      //                         onPress: cancelOrder,
      //                         textColor: whiteColor,
      //                         title: "Cancel Order",
      //                     ),
      //                   ),
      appBar: AppBar(
        title: "Order Details".text.fontFamily(semibold).color(darkFontGrey).make(),  
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          // scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              orderStatus(color: redColor, icon: Icons.done, title: "Placed", showDone: data['order_placed']),
              orderStatus(color: Colors.greenAccent, icon: Icons.thumb_up, title: "Confirmed", showDone: data['order_confirmed']),
              orderStatus(color: Colors.blue, icon: Icons.local_shipping, title: "On Delivery", showDone: data['order_on_delivery']),
              orderStatus(color: Colors.purple, icon: Icons.done_all_rounded, title: "Delivered", showDone: data['order_delivered']),
              
              const Divider(),
              
              10.heightBox,
              "Delivery Details".text.size(16).color(darkFontGrey).fontFamily(semibold).makeCentered(),
              10.heightBox,
        
              orderPlaceDetails2(
                d1: data['order_code'],
                // d2: data['shipping_method'],
                title1: "Order Code",
                // title2: "Shipping Method",
              ),
              orderPlaceDetails(
                d1: intl.DateFormat("yyyy.MMMM.dd hh:mm aaa").format((data['order_date'].toDate())),
                d2: data['payment_method'],
                title1: "Order Date",
                title2: "Payment Method",
              ),
              orderPlaceDetails(
                d1: "Unpaid",
                d2: "Order Placed",
                title1: "Order Date",
                title2: "Delivery Status",
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 102.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Delivery Address".text.size(16).color(darkFontGrey).fontFamily(semibold).make(),
                          "${data['order_by_name']}".text.color(Color.fromRGBO(4, 84, 158, 30)).fontFamily(bold).make(),
                          // "${data['order_by_email']}".text.make(),
                          "${data['order_by_address']}".text.color(Color.fromRGBO(4, 84, 158, 30)).fontFamily(bold).make(),
                          "${data['order_by_city']}".text.color(Color.fromRGBO(4, 84, 158, 30)).fontFamily(bold).make(),
                          // "${data['order_by_state']}".text.make(),
                          "${data['order_by_phone']}".text.color(Color.fromRGBO(4, 84, 158, 30)).fontFamily(bold).make(),
                          // "${data['order_by_postalcode']}".text.make(),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 130,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Total Amount".text.fontFamily(semibold).make(),
                          "${data['total_amount']}".numCurrency.text.color(Color.fromRGBO(4, 84, 158, 30),).fontFamily(bold).make(),
                        ],
                      ),
                    ),
                  ],
                ),
              ).box.outerShadowMd.white.make(),
        
              const Divider(),
              10.heightBox,
              "Ordered Product".text.size(16).color(darkFontGrey).fontFamily(semibold).makeCentered(),
        
              10.heightBox,
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(data['orders'].length, (index){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                orderPlaceDetails3(
                                  title1: data['orders'][index]['title'],
                                  title2: data['orders'][index]['tprice'].toString().numCurrency,
                                  d1: "${data['orders'][index]['qty']}x",
                                  // d2: "Refundable"
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Container(
                                    width: 30,
                                    height: 15,
                                    // color: Color(data['orders'][index]['color']),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
              ).box.outerShadowMd.white.margin(const EdgeInsets.only(bottom: 4)).padding(const EdgeInsets.only(bottom: 8)).make(),

              10.heightBox,

              // ButtonBar(
              //   alignment: MainAxisAlignment.spaceEvenly,
              //   children: <Widget>[
              //     ElevatedButton(
              //       onPressed: _showSnack, 
              //       child: const Text("Cancel"),
              //     ),
              //   ],
              // ),
              
              20.heightBox,
              

        
              
            ],
          ),
        ),
      ),
    );
  }
}