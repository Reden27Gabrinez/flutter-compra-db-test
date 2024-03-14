import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compra/consts/consts.dart';
import 'package:compra/consts/lists.dart';
import 'package:compra/controller/auth_controller.dart';
import 'package:compra/controller/profile_controller.dart';
import 'package:compra/services/firestore_services.dart';
import 'package:compra/views/auth_screen/login_screen.dart';
import 'package:compra/views/chat_screen/chat_screen.dart';
import 'package:compra/views/chat_screen/messaging_screen.dart';
import 'package:compra/views/orders_screen/orders_screen.dart';
import 'package:compra/views/policy/about.dart';
import 'package:compra/views/policy/messaging.dart';
import 'package:compra/views/policy/policyprivacy.dart';
import 'package:compra/views/policy/feedback.dart';
import 'package:compra/views/profile_screen/chatpage.dart';
import 'package:compra/views/profile_screen/components/details_card.dart';
import 'package:compra/views/profile_screen/components/edit_profile_screen.dart';
import 'package:compra/views/profile_screen/components/widgets.dart';
import 'package:compra/views/wishlist_screen/wishlist_screen.dart';
import 'package:compra/widgets_common/bg_widget.dart';
import 'package:compra/widgets_common/loading_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

      // Initialize the time zone database
  tz.initializeTimeZones();

  // Specify the UTC+8 time zone
  final timeZone = tz.getLocation('Asia/Singapore'); // Change to your desired timezone


    var controller = Get.put(ProfileController());
    // FirestoreServices.getCounts();

    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        
            if(!snapshot.hasData)
            {
              return Center(
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),),
              );
            }
            else
            {
        
              var data = snapshot.data!.docs[0];
        
        
              return SingleChildScrollView(
                child: SafeArea(child: Column(
                            children: [
                
                
                              // //edit profile button
                              // Container(
                              //   margin: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0, bottom: 8.0),
                              //   child: const Align(
                              //     alignment: Alignment.topRight,
                              //     child: Icon(Icons.edit, color: whiteColor,)).onTap(() { 
                              //       controller.nameController.text = data['name'];
                              //       Get.to(() => EditProfileScreen(data: data));
                              //     }),
                              // ),
              
                              //LOGOUT BUTTON
                              Container(
                                margin: EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0, bottom: 0),
                                child: const Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(Icons.exit_to_app_outlined, color: whiteColor,)).onTap(() async { 
                                    await Get.put(AuthController()).signoutMethod(context);
                                    Get.offAll(() => LoginScreen());
                                  }),
                              ),
                
                
                
                
                              //users details section NAME/EMAIL
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                
                                    data['imageUrl'] == '' ?
                
                                    Image.asset(
                                      unknownProfile, 
                                      width: 90,
                                      fit: BoxFit.cover,
                                    ).box.roundedFull.clip(Clip.antiAlias).make()
                                    :
                                    Image.network(
                                      data['imageUrl'], 
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ).box.roundedFull.clip(Clip.antiAlias).make(),
                
                
                                       //Name
                                    10.widthBox,
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              "${data['name']}".text.fontFamily(bold).size(25).white.make(),
                                              10.widthBox,
                                              Icon(Icons.edit, size: 20, color: whiteColor).onTap(() { 
                                                controller.nameController.text = data['name'];
                                                Get.to(() => EditProfileScreen(data: data));
                                              }),
                                            ],
                                          ),
                                          //EMAIL
                                          "${data['email']}".text.size(15).white.make(),
                                        ],
                                      ),
                                    ),
              
              
                                    // Expanded(child: Column(
                                    //   crossAxisAlignment: CrossAxisAlignment.start,
                                    //   children: [
                                    //     "${data['name']}".text.fontFamily(bold).size(25).white.make(),
                                        
                                    //     Icon(Icons.edit, color: whiteColor,).onTap(() { 
                                    //         controller.nameController.text = data['name'];
                                    //         Get.to(() => EditProfileScreen(data: data));
                                    //       }),
                                        
                                    //     "${data['email']}".text.white.make(),
                                    //   ],
                                    // )),
              
                                    // OutlinedButton(
                                    //   style: OutlinedButton.styleFrom(
                                    //     side: const BorderSide(
                                    //       color: whiteColor,
                                    //     ),
                                    //   ),
                                    //   onPressed: () async {
                                    //     await Get.put(AuthController()).signoutMethod(context);
                                    //     Get.offAll(() => LoginScreen());
                                    //   }, 
                                    //   child: logout.text.fontFamily(semibold).white.make(),
                                    // ),
              
                                    // Container(
                                    //   margin: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0, bottom: 8.0),
                                    //   child: const Align(
                                    //     alignment: Alignment.topRight,
                                    //     child: Icon(Icons.edit, color: whiteColor,)).onTap(() { 
                                    //       controller.nameController.text = data['name'];
                                    //       Get.to(() => EditProfileScreen(data: data));
                                    //     }),
                                    // ),
                                  ],
                                ),
                              ),
                
                              // 20.heightBox,
                
                              FutureBuilder(
                                future: FirestoreServices.getCounts(),
                                builder: (BuildContext context, AsyncSnapshot snapshot)
                                {
                                  if(!snapshot.hasData)
                                  {
                                    return Center(child: loadingIndicator());
                                  }
                                  else
                                  {
                                    //3 KA SQUARES, CART/WISHLIST/ORDERS
                                    var countData = snapshot.data;
                                    print(snapshot.data);
                                    return  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        detailsCard(count: countData[0].toString(), title: "Cart", width: context.screenWidth / 3.4),
                                        detailsCard(count: countData[1].toString(), title: "Wishlist", width: context.screenWidth / 3.4),
                                        detailsCard(count: countData[2].toString(), title: "Orders", width: context.screenWidth / 3.4),
                                      ],
                                    );
                                  }
                                }
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              //   children: [
                              //     detailsCard(count: data['cart_count'], title: "in your cart", width: context.screenWidth / 3.4),
                              //     detailsCard(count: data['wishlist_count'], title: "in your wishlist", width: context.screenWidth / 3.4),
                              //     detailsCard(count: data['order_count'], title: "your orders", width: context.screenWidth / 3.4),
                              //   ],
                              // ),
                
                
                
                
                              //BUTTONS SECTION
                              ListView.separated(
                                shrinkWrap: true,
                                separatorBuilder: (context, index) {
                                  return const Divider(
                                    color: lightGrey,
                                  );
                                },
                                itemCount: profileButtonsList.length,
                                itemBuilder: (BuildContext context, int index){
                                  return ListTile(
                                    onTap: () {
                                      switch (index) {
                                        case 0:
                                          Get.to(() => const OrderScreen());
                                         break;
                                        case 1:
                                          Get.to(() => const WishlistScreen());
                                          break;
                                        case 2:
                                          Navigator.of(context)
                                              .push(
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return ChatPage(
                                                  senderName: data['name'],
                                                  token: data['user-token'],
                                                  id: "aTeJ9DFCpcUX3gaHZ5A6I2axfgK2",
                                                  name: "Harry Guantero Trading",
                                                );
                                              },
                                            ),
                                          );
                                          break;
                                        case 3:
                                          // Launch an SMS composer with a predefined phone number
                                          final phoneNumber = '09092890482';
                                          final Uri url = Uri(scheme: 'sms', path: phoneNumber);
                                          launchUrl(url).then((value) {
                                            print("Success: URL launched");
                                          }).catchError((error) {
                                            print('Show dialog: Cannot launch URL');
                                          });
                                          break;
                                        case 4:
                                          Get.to(() => const UserFeedback());                                 
                                          break;
                                        case 5:
                                          Get.to(() => const PolicyPrivacy());
                                          break;
                                        case 6:
                                          Get.to(() => const AboutUs());
                                      } 
                                    },
                                    //ICON BUTTON IMAGES
                                    leading: Image.asset(
                                      profileButtonsIcon[index],
                                      width: 22,
                                    ),
                                    title: profileButtonsList[index].text.fontFamily(semibold).color(darkFontGrey).make(),
                                  );
                                }, 
                              ).box.white.rounded.margin(EdgeInsets.all(12)).padding(EdgeInsets.symmetric(horizontal: 16)).shadowSm.make().box.make(),
                            ],
                          )),
              );
            }
        
          },
        ),
      ),
    );
  }
}