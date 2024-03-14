import 'package:compra/consts/consts.dart';

Widget customTextField({String? title, String? hint, controller,isPass, readOnly2})
{
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(Color.fromRGBO(4, 84, 158, 30), ).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
        readOnly: readOnly2,
        obscureText: isPass,
        controller: controller,
        decoration: InputDecoration(
          hintStyle: TextStyle(
            fontFamily: semibold,
            color: textfieldGrey,
          ),
          hintText: hint,
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.yellow, 
            ),
          ),
        ),
      ),
      5.heightBox,
    ],
  );
}