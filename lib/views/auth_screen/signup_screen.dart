import 'package:compra/consts/consts.dart';
import 'package:compra/controller/auth_controller.dart';
import 'package:compra/views/auth_screen/login_screen.dart';
import 'package:compra/views/home_screen/home.dart';
import 'package:compra/widgets_common/applogo_widget.dart';
import 'package:compra/widgets_common/bg_widget.dart';
import 'package:compra/widgets_common/custom_textfield.dart';
import 'package:compra/widgets_common/our_button.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  bool? isCheck = false;
  var controller = Get.put(AuthController());

  //text controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Join the $appname".text.fontFamily(bold).color(Color.fromARGB(255,254, 240, 2)).size(18).make(),
            15.heightBox,
            Obx(
              () => Column(
                children: [
                  customTextField(hint: nameHint, readOnly2: false,title: name, controller: nameController,isPass: false),
                  customTextField(hint: emailHint, readOnly2: false,title: email, controller: emailController,isPass: false),
                  customTextField(hint: passwordHint, readOnly2: false,title: password, controller: passwordController, isPass: true),
                  customTextField(hint: passwordHint, readOnly2: false,title: retypePassword, controller: passwordRetypeController,isPass: true),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: TextButton(onPressed: (){}, child: forgetPass.text.make())
                  // ),
            
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Row(
                      children: [
                        Checkbox(
                          checkColor: redColor,
                          value: isCheck, 
                          onChanged: (newValue){
                            setState(() {
                              isCheck = newValue;
                            });                      
                          },
                        ),
                        10.widthBox,
                        Expanded(
                          child: TextButton
                          (
                            child: RichText(text: const TextSpan(
                              children: [
                                TextSpan(text: "I agree to the ", 
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: Color.fromRGBO(4, 84, 158, 30),
                                )),
                                TextSpan(text: termsAndCond, 
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: Color.fromRGBO(4, 84, 158, 30), 
                                )),
                                TextSpan(text: " & ", 
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: Color.fromRGBO(4, 84, 158, 30), 
                                )),
                                TextSpan(text: privacyPolicy, 
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: Color.fromRGBO(4, 84, 158, 30), 
                                ))
                              ],
                            )),
                            onPressed: () => showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Terms and Conditions & Privacy Policy'),
                                              content: 



SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [

            //title
            Text(
              "Last updated: October 2023",
              style: TextStyle(
                fontSize: 16, 
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Welcome to Client Optimized Management of Products and Retail Application with Systemized Assistant for Harry Guantero Trading – COMPRA SA HGT. At COMPRA SA HGT, we are committed to protecting your privacy. This Privacy Policy outlines how we collect, use, disclose and safeguard your personal information when you visit our website.",
              style: TextStyle(
                fontSize: 16, 
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            //title
            Text(
              "Information We Collect",
              style: TextStyle(

               fontSize: 16,

                fontWeight: FontWeight.bold
              ),            
            ),
            SizedBox(height: 10),
            Text(
              "Personal Information: When you create an account or make a purchase, we may collect your name, address, email address, contact number, mode of delivery, feedback and payment information.",
              style: TextStyle(
                fontSize: 16, 
                color: Colors.black,
              ),
            ),SizedBox(height: 20),
            //title
            Text(
              "How We Use Your Information",
              style: TextStyle(

               fontSize: 16,

                fontWeight: FontWeight.bold
              ),            
            ),
            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                style: TextStyle(

                  fontSize: 15,
                  color: Colors.black,

                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '• To provide and maintain our services.\n',
                  ),
                  TextSpan(
                    text: '• To process transactions and fulfill orders.\n',
                  ),
                  TextSpan(
                    text: '• To personalize your experience.\n',
                  ),
                  TextSpan(
                    text: '• To analyze and improve our services.\n',
                  ),
                  TextSpan(
                    text: '• To communicate with you regarding updates, promotions, and customer support.',
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            //title
            Text(
              "Sharing Your Information",
              style: TextStyle(

               fontSize: 16,

                fontWeight: FontWeight.bold
              ),            
            ),
            SizedBox(height: 20),
            Text(
              "We may share your information with trusted third parties, such as payment processors or service providers, to facilitate our operations. We will never sell your personal information to third parties.",
              style: TextStyle(
                fontSize: 16, 
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            //title
            Text(
              "Security",
              style: TextStyle(

               fontSize: 16,

                fontWeight: FontWeight.bold
              ),            
            ),
            SizedBox(height: 20),
            Text(
              "We take reasonable measures to protect your personal information from unauthorized access or disclosure.",
              style: TextStyle(
                fontSize: 16, 
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            //title
            Text(
              "Contact Us",
              style: TextStyle(

               fontSize: 16,

                fontWeight: FontWeight.bold
              ),            
            ),
            SizedBox(height: 20),
            Text(
              "If you have questions or concerns about this Privacy Policy, please contact us.",
              style: TextStyle(
                fontSize: 16, 
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
          ],
        )
      ),



















                          );
                                    },
                                  )),
                        ),
                      ],
                    ),
                  ),
                  5.heightBox,
                  // ourButton().box.width(context.screenWidth - 50).make(),
                  controller.isloading.value? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Color.fromARGB(255,254, 240, 2)),
                  ): ourButton(
                    color: isCheck == true ? Color.fromRGBO(4, 84, 158, 30) : lightGrey, 
                    title: signup, 
                    textColor: Color.fromARGB(255,254, 240, 2), 
                    onPress: () async 
                    {
                      if(isCheck != false)
                      {
                        controller.isloading(true);
                        try {
                          await controller.signupMethod(context: context,email: emailController.text,password: passwordController.text).then((value){
                            return controller.storeUserData(
                              email: emailController.text,
                              password: passwordController.text,
                              name: nameController.text
                            );
                          }).then((value){
                            VxToast.show(context, msg: loggedin);
                            // Get.offAll(()=>Home());
                          });
                          
                        } catch (e) {
                          auth.signOut();
                          VxToast.show(context, msg: e.toString());
                          controller.isloading(false);
                        }
                      }
                    }
                  )
                  .box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  // wrapping into gesture detector of velocity X
                  RichText(text: const TextSpan(
                    children: [
                      TextSpan(
                        text: alreadyHaveAccount,
                        style: TextStyle(
                          fontFamily: bold,
                          color: fontGrey,
                        ),
                      ),
                      TextSpan(
                        text: login,
                        style: TextStyle(
                          fontFamily: bold,
                          color: Color.fromRGBO(4, 84, 158, 30), 
                        ),
                      ),
                    ],
                  ),).onTap(() { 
                    Get.back();
                  })
            
                ],
              ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth - 70).shadowSm.make(),
            ),
          ],
        ),
      ),
    ));
  }
}