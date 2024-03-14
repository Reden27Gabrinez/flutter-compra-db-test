import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compra/consts/consts.dart';
import 'package:intl/intl.dart' as intl;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Widget senderBubble(DocumentSnapshot data) {
  // Initialize the time zone database
  tz.initializeTimeZones();

  // Specify the UTC+8 time zone
  final timeZone = tz.getLocation('Asia/Singapore'); // Change to your desired timezone

  var t = data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();

  // Convert the time to the specified time zone
  final tzTime = tz.TZDateTime.from(t, timeZone);

  // Format the time in the desired format
  var time = intl.DateFormat("h:mma").format(tzTime);

  return Directionality(
    textDirection: data['uid'] == currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
    child: Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: data['uid'] == currentUser!.uid ? const Color.fromARGB(255, 38, 113, 173) : Colors.black45,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          "${data['msg']}".text.white.size(16).make(),
          10.heightBox,
          time.text.color(whiteColor.withOpacity(0.5)).make(),
        ],
      ),
    ),
  );
}



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:compra/consts/consts.dart';
// import 'package:intl/intl.dart' as intl;

// Widget senderBubble(DocumentSnapshot data)
// {

//   var t = data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
//   var time = intl.DateFormat("h:mma").format(t);

//   return Directionality(
//     textDirection: data['uid'] == currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
//     child: Container(   
//             padding: const EdgeInsets.all(8),
//             margin: const EdgeInsets.only(bottom: 8),
//             decoration: BoxDecoration(
//               color: data['uid'] == currentUser!.uid ? const Color.fromARGB(255, 38, 113, 173) : Colors.black45,
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(20),
//                 topRight: Radius.circular(20),
//                 bottomLeft: Radius.circular(20),
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 "${data['msg']}".text.white.size(16).make(),
//                 10.heightBox,
//                 time.text.color(whiteColor.withOpacity(0.5)).make(),
//               ],
//             ),
//     ),
//   );
// }