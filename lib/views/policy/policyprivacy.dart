import 'package:compra/consts/consts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class PolicyPrivacy extends StatelessWidget {
  const PolicyPrivacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Privacy Policy".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Text(
                    "Privacy Policy of COMPRA SA HGT App",
                    style: TextStyle(

                     fontSize: 16,

                      fontWeight: FontWeight.bold
                    ),            
                  ),
                  SizedBox(height: 20),
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
                  // SizedBox(height: 20),
                  // //title
                  // Text(
                  //   "How We Use Your Information",
                  //   style: TextStyle(

                  //    fontSize: 16,

                  //     fontWeight: FontWeight.bold
                  //   ),            
                  // ),
                  // SizedBox(height: 20),
                  // Text(
                  //   "We want to inform you that whenever you visit our Service, we collect information that your browser sends to us that is called Log Data. This Log Data may include information such as your computer's Internet Protocol (“IP”) address, browser version, pages of our Service that you visit, the time and date of your visit, the time spent on those pages, and other statistics.",
                  //   style: TextStyle(
                  //     fontSize: 16, 
                  //     color: Colors.black,
                  //   ),
                  // ),
                  // SizedBox(height: 20),
                  // //title
                  // Text(
                  //   "Cookies",
                  //   style: TextStyle(

                  //    fontSize: 16,

                  //     fontWeight: FontWeight.bold
                  //   ),            
                  // ),
                  // SizedBox(height: 20),
                  // Text(
                  //   "Cookies are files with small amount of data that is commonly used an anonymous unique identifier. These are sent to your browser from the website that you visit and are stored on your computer's hard drive.",
                  //   style: TextStyle(
                  //     fontSize: 16, 
                  //     color: Colors.black,
                  //   ),
                  // ),
                  // SizedBox(height: 10),
                  // Text(
                  //   "Our website uses these “cookies” to collection information and to improve our Service. You have the option to either accept or refuse these cookies, and know when a cookie is being sent to your computer. If you choose to refuse our cookies, you may not be able to use some portions of our Service.",
                  //   style: TextStyle(
                  //     fontSize: 16, 
                  //     color: Colors.black,
                  //   ),
                  // ),
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
                  // SizedBox(height: 20),
                  // //title
                  // Text(
                  //   "Changes to This Privacy Policy",
                  //   style: TextStyle(

                  //    fontSize: 16,

                  //     fontWeight: FontWeight.bold
                  //   ),            
                  // ),
                  // SizedBox(height: 20),
                  // Text(
                  //   "We may update our Privacy Policy from time to time. Thus, we advise you to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page. These changes are effective immediately, after they are posted on this page.",
                  //   style: TextStyle(
                  //     fontSize: 16, 
                  //     color: Colors.black,
                  //   ),
                  // ),
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
              ),
            ),
          ],
        ).box.white.rounded.margin(EdgeInsets.all(12)).padding(EdgeInsets.symmetric(horizontal: 16)).shadowSm.make().box.make(),
      ),
    );
  }
}