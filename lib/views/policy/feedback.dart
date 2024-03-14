// import 'package:compra/consts/consts.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/widgets.dart';

// class UserFeedback extends StatelessWidget {
//   const UserFeedback({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController _feedbackController = TextEditingController();
//     return Scaffold(
//       backgroundColor: whiteColor,
//       appBar: AppBar(
//         title: "User Feedback".text.color(darkFontGrey).fontFamily(semibold).make(),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             50.heightBox,
//             Text('Your Feedback:'),
//             TextFormField(
//               controller: _feedbackController,
//               maxLines: 2,
//             ),
//             SizedBox(height: 20),
//             OutlinedButton(
//               onPressed: () {
//                 // Implement feedback submission logic here
//                 // You can send the feedback to your server or save it locally.
//               },
//               child: Text('Submit Feedback'),

//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:compra/consts/consts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserFeedback extends StatelessWidget {
  const UserFeedback({super.key});

  // Function to send feedback to Firestore
  Future<void> sendFeedbackToFirestore(String feedback) async {
    try {
      // Initialize Firebase if it hasn't been initialized yet
      await Firebase.initializeApp();

      // Reference to the Firestore collection where you want to store feedback
      CollectionReference feedbackCollection =
          FirebaseFirestore.instance.collection('feedback');

      // Add the feedback to Firestore
      await feedbackCollection.add({
        'user': currentUser!.uid,
        'feedback_text': feedback,
        'timestamp': FieldValue.serverTimestamp(),
      });


      // Feedback successfully submitted
      print('Feedback submitted successfully');
    } catch (e) {
      // Handle any errors that occur during the process
      print('Error submitting feedback: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _feedbackController = TextEditingController();

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "User Feedback".text.color(darkFontGrey).size(20).fontFamily(bold).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Text('Your Feedback:'),
            TextFormField(
              controller: _feedbackController,
              maxLines: 2,
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                onPressed: () {
                  // Get the feedback text from the controller
                  String feedbackText = _feedbackController.text;
            
                  // Check if the feedback is not empty
                  if (feedbackText.isNotEmpty) {
                    // Send the feedback to Firestore
                    sendFeedbackToFirestore(feedbackText);
                    Navigator.pop(context);
                  } else {
                    // Handle empty feedback
                    print('Feedback cannot be empty');
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(4, 84, 158, 30),
                ),
                child: Text('Submit Feedback',style: TextStyle(color: Color.fromARGB(255,254, 240, 2)),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
