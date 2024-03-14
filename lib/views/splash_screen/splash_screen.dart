import 'package:compra/consts/colors.dart';
import 'package:compra/consts/consts.dart';
import 'package:compra/views/auth_screen/login_screen.dart';
import 'package:compra/views/home_screen/home.dart';
import 'package:compra/widgets_common/applogo_widget.dart';
import 'package:compra/widgets_common/bg_widget.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  // creting a method to change screen and check internet connectiviy
  changeScreen() async {
    // Check for internet connectivity
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      // No internet, show loading screen or error message
      showNoInternetLoading();
    } else {
      // Internet is available, proceed with your original logic
      Future.delayed(const Duration(seconds: 3), () {
        auth.authStateChanges().listen((User? user) {
          if (user == null && mounted) {
            Get.to(() => LoginScreen());
          } else {
            Get.to(() => const Home());
          }
        });
      });
    }
  }

  void showNoInternetLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('No Internet Connection'),
          content: Text('Please check your internet connection and try again.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Optionally, you can exit the app or perform other actions here.
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState()
  {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        body: Center(
          child: Container(
            height: 212,
            child: Column(
              children: [
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: Image.asset(icSplashBg, width: 300)
                //   ),
                  20.heightBox,
                  applogoWidget(),
                  10.heightBox,
                  appname.text.fontFamily(bold).size(22).white.make(),
                  5.heightBox,
                  appversion.text.white.make(),
                  Spacer(),
                  40.heightBox,
                  credits.text.white.fontFamily(semibold).make(),
                  
                  // flashscreen ui is complete
              ],
            ),
          ),
        ),
      ),
    );
  }
}