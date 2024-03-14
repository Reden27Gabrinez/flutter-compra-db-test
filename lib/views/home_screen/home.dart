import 'package:compra/consts/consts.dart';
import 'package:compra/controller/home_controller.dart';
import 'package:compra/views/cart_screen/cart_screen.dart';
import 'package:compra/views/category_screen/category_screen.dart';
import 'package:compra/views/home_screen/home_screen.dart';
import 'package:compra/views/profile_screen/profile_screen.dart';
import 'package:compra/widgets_common/exit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    //init home controller
    var controller = Get.put(HomeController());

    var navbarItem = [
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: home),
        const BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: categories),
        const BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: cart),
        const BottomNavigationBarItem(icon: Icon(Icons.person), label: account),
      // BottomNavigationBarItem(icon: Image.asset(icHome, width: 26, color: Color.fromRGBO(4, 84, 158, 30)), label: home),
      // BottomNavigationBarItem(icon: Image.asset(icCategories, width: 26, color: Color.fromRGBO(4, 84, 158, 30)), label: categories),
      // BottomNavigationBarItem(icon: Image.asset(icCart, width: 26, color: Color.fromRGBO(4, 84, 158, 30)), label: cart),
      // BottomNavigationBarItem(icon: Image.asset(icProfile, width: 26, color: Color.fromRGBO(4, 84, 158, 30)), label: account)
    ];

    var navBody = [
      const HomeScreen(),
       CategoryScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];


    return WillPopScope(
      onWillPop: () async {
        showDialog(
          barrierDismissible: false,
          context: context, builder: (context) => exitDialog(context)
        );
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx
            (()=>
              Expanded(
                child: navBody.elementAt(controller.currentNavIndex.value)
              ),
            ),
          ],
        ),
        bottomNavigationBar: Obx(()=>
          BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            selectedItemColor:  Color.fromRGBO(4, 84, 158, 30),
            selectedLabelStyle: const TextStyle(
              fontFamily: semibold,
            ),
            type: BottomNavigationBarType.fixed,
            backgroundColor: whiteColor,
            items: navbarItem,
            onTap: (value) {
              controller.currentNavIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}