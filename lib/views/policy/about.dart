import 'package:compra/consts/consts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "About Us".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                    'assets/icons/playstore.png',
                      height: 120,
                      width: 120,
                    ),
                  ),
                  // const SizedBox(height: 30),
                  // const Text(
                  //   "Privacy Policy of COMPRA SA HGT App",
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.bold
                  //   ),            
                  // ),
                  const SizedBox(height: 20),
                  //title
                  const Text(
                    "M. Revil St. Corner Barrientos St., Poblacion 2, Oroquieta City Misamis Occidental, Philippines",
                    style: TextStyle(
                      fontSize: 16, 
                      color: Colors.black
                    ),
                  ),
                  const SizedBox(height: 20),
                  //title
                  const Text(
                    "Contact",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),            
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () async {
                        final Uri url = Uri(
                          scheme: 'sms',
                          path: '09092890482',
                        );
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                          print("Success: URL launched");
                        } else {
                          print('Show dialog: Cannot launch URL');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(4, 84, 158, 30),
                      ),
                      child: const Text("09092890482"),
                    ),
                  const SizedBox(height: 20),
                  //title
                  const Text(
                    "Email Address",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),            
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "hgt.oroquieta@gmail.com",
                    style: TextStyle(
                      fontSize: 16, 
                      color: Colors.black
                    ),
                  ),
                  const SizedBox(height: 20),
                  //title
                  const Text(
                    "Visit our Facebook",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),            
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "www.facebook.com/hgtoroquieta",
                    style: TextStyle(
                      fontSize: 16, 
                      color: Colors.black
                    ),
                  ),
                  const SizedBox(height: 20),
                  //title
                  const Text(
                    "Core Values",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),            
                  ),
                  const SizedBox(height: 10),
                   RichText(
                    text: TextSpan(
                      style: TextStyle(

                        fontSize: 16,
                        color: Colors.black,

                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '• Hardwork\n',
                        ),
                        TextSpan(
                          text: '• Godly\n',
                        ),
                        TextSpan(
                          text: '• Trustworthy\n',
                        ),
                        
                        
                      ],
                    ),
                  ),
                  // const Text(
                  //   "The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible at Website URL, unless otherwise defined in this Privacy Policy.",
                  //   style: TextStyle(
                  //     fontSize: 16, 
                  //     color: Colors.black
                  //   ),
                  // ),
                  const SizedBox(height: 10),
                  //title
                  const Text(
                    "Vision",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),            
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "HGT aims to be a leading household by-word and a popular choice of destination for quality retail goods.",
                    style: TextStyle(
                      fontSize: 16, 
                      color: Colors.black
                    ),
                  ),
                  const SizedBox(height: 20),
                  //title
                  const Text(
                    "Mission",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),            
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "HGT is committed to the delivery of superior quality retailing service with a workforce that gives value to integrity, hardwork, and total customer satisfaction.",
                    style: TextStyle(
                      fontSize: 16, 
                      color: Colors.black
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ).box.white.rounded.margin(const EdgeInsets.all(12)).padding(const EdgeInsets.symmetric(horizontal: 16)).shadowSm.make().box.make(),
      ),
    );
  }
}