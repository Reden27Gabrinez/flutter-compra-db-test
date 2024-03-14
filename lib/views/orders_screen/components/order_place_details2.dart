import 'package:compra/consts/consts.dart';

Widget orderPlaceDetails2({title1, title2, d1, d2})
{
  return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "$title1".text.fontFamily(semibold).make(),
                      "$d1".text.color(Color.fromRGBO(4, 84, 158, 30),).fontFamily(semibold).make(),
                    ],
                  ),
                  // SizedBox(
                  //   width: 130,
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       "$title2".text.fontFamily(semibold).make(),
                  //       "$d2".text.make(),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            );
}