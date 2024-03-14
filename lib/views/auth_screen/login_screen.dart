import 'package:compra/consts/consts.dart';
import 'package:compra/controller/auth_controller.dart';
import 'package:compra/views/auth_screen/signup_screen.dart';
import 'package:compra/views/home_screen/home.dart';
import 'package:compra/widgets_common/applogo_widget.dart';
import 'package:compra/widgets_common/bg_widget.dart';
import 'package:compra/widgets_common/custom_textfield.dart';
import 'package:compra/widgets_common/our_button.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../consts/lists.dart';
// import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   TextEditingController emailController = TextEditingController();

   @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Save a reference to the ScaffoldMessenger here
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    // You can now use scaffoldMessenger in your _resetPassword method
  }

  // Function to handle password reset
  Future<void> _resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // Show a success message to the user
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text("Password reset email sent. Check your inbox"),
          duration: Duration(seconds: 2), // Adjust the duration as needed
        ),
      );
    } catch (e) {
      // Show an error message if password reset fails
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text("Password reset failed. Please try again."),
          duration: Duration(seconds: 2), // Adjust the duration as needed
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(AuthController());

    return bgWidget(child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Log in to $appname".text.fontFamily(bold).color(Color.fromARGB(255,254, 240, 2),).size(18).make(),
            15.heightBox,
            Obx(
              () => Column(
                children: [
                  customTextField(hint: emailHint, readOnly2: false,title: email,isPass: false,controller: controller.emailController),
                  customTextField(hint: passwordHint, readOnly2: false,title: password,isPass: true,controller: controller.passwordController),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: TextButton(onPressed: (){}, child: forgetPass.text.make())
                  // ),

                  // "Forgot Password" button
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Forgot Password'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Enter your email to reset your password:'),
                        TextField(
                          controller: emailController, // You can add a TextEditingController here.
                          decoration: InputDecoration(labelText: 'Email'),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Reset Password'),
                        onPressed: () {
                      // Get the email from the TextField
                          _resetPassword(emailController.text.trim());
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Text('Forgot Password'),
          ),
        ),


                  5.heightBox,
                  controller.isloading.value ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Color.fromARGB(255,254, 240, 2)),
                  ) : 
                  ourButton(
                    color: Color.fromRGBO(4, 84, 158, 30), 
                    title: login, 
                    textColor: Color.fromARGB(255,254, 240, 2), 
                    onPress: () async {
                      controller.isloading(true);
                      await controller.loginMethod(context: context).then((value){
                        if(value != null)
                        {
                          VxToast.show(context, msg: loggedin);
                          Get.offAll(()=>const Home());
                        }
                        else
                        {
                          controller.isloading(false);
                        }
                      });
                    },
                  )
                  .box.width(context.screenWidth - 50).make(),
                  5.heightBox,
                  createNewAccount.text.color(Color.fromRGBO(4, 84, 158, 30), ).make(),
                  5.heightBox,
                  ourButton(
                    color: Color.fromRGBO(4, 84, 158, 30), 
                    title: signup, 
                    textColor: Color.fromARGB(255,254, 240, 2), 
                    onPress: () {
                      Get.to(()=>const SignupScreen());
                    }
                  )
                  .box.width(context.screenWidth - 50).make(),
            
                  // 10.heightBox,
                  // loginWith.text.color(fontGrey).make(),
                  // 5.heightBox,
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: List.generate(3, (index) => Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: CircleAvatar(
                  //       backgroundColor: lightGrey,
                  //       radius: 25,
                  //       child: Image.asset(socialIconList[index],
                  //       width: 30,
                  //     ),
                  //     ),
                  //   )),
                  // ),
            
                ],
              ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth - 70).shadowSm.make(),
            ),
          ],
        ),
      ),
    ));
  }
}