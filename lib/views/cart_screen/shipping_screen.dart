import 'package:compra/consts/consts.dart';
import 'package:compra/controller/cart_controller.dart';
import 'package:compra/views/cart_screen/payment_method.dart';
import 'package:compra/widgets_common/custom_textfield.dart';
import 'package:compra/widgets_common/our_button.dart';
import 'package:get/get.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});
//DELIVERY INFO TEXT
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Delivery Info".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          onPress: () {
            if (controller.addressController.text.length > 5) {
                    if (controller.phoneController.text.length < 11) {
                        VxToast.show(context, msg: "Insufficient Numbers");
                    }
                    else
                    {

                      if (controller.phoneController.text.length > 11) {
                        VxToast.show(context, msg: "  Phone Number Exceeds");
                      }
                      else
                      {

                        if (controller.phoneController.text.length == 11) {
                          Get.to(() => const PaymentMethods());
                        }
                        else
                        {
                          VxToast.show(context, msg: "identification");
                        }
                      }
                    }
            }
            else 
            {
              VxToast.show(context, msg: "Please fill the form");
            }
          },
          //CONTINUE
          color: const Color.fromRGBO(4, 84, 158, 30), 
          textColor: Color.fromARGB(255,254, 240, 2),
          title: "Continue",
        ),
      ),
      //DELIVERY INFO LANG GIHAPON
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextField(hint: "House no. Purok, Barangay", readOnly2: false, isPass: false, title: "Complete Address", controller: controller.addressController),
            // customTextField(hint: "State", readOnly2: false, isPass: false, title: "State", controller: controller.stateController),
            customTextField(hint: "09xxxxxxxxx", readOnly2: false, isPass: false, title: "Phone", controller: controller.phoneController),
            customTextField(hint: "Oroquieta City", readOnly2: true, isPass: false, title: "City", controller: controller.cityController),
            // customTextField(hint: "7207", readOnly2: true, isPass: false, title: "Postal Code", controller: controller.postalcodeController),
          ],
        ),
      ),
    );
  }
}