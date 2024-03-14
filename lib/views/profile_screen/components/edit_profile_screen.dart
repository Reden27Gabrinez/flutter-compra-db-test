import 'dart:io';

import 'package:compra/consts/consts.dart';
import 'package:compra/controller/profile_controller.dart';
import 'package:compra/widgets_common/bg_widget.dart';
import 'package:compra/widgets_common/custom_textfield.dart';
import 'package:compra/widgets_common/our_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<ProfileController>();
    // controller.nameController.text = data['name'];
    // controller.passController.text = data['password'];


    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: "Update Profile".text.fontFamily(bold).white.make(),
        ),
        body: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
        
        
        
              //if data image url and controller path is empty
              data['imageUrl'] == '' && controller.profileImgPath.isEmpty 
                ? Image.asset(
                    unknownProfile, 
                    width: 100,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make() 

                  //if data is not empty but controller path is empty
                : data['imageUrl'] != '' && controller.profileImgPath.isEmpty
                

                ? Image.network(data['imageUrl'],width: 100,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make()
                

                //else if controller path is not empty but data image url is
                : Image.file(
                    File(controller.profileImgPath.value),
                    width: 100,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make(),
        
        
        
        
        
        
              10.heightBox,
              ourButton(color:  Color.fromRGBO(4, 84, 158, 30),onPress: (){
                controller.changeImage(context);
              },textColor: Color.fromARGB(255,254, 240, 2),title: "Change"),
              Divider(),
              20.heightBox,
              customTextField(controller: controller.nameController,hint: nameHint, readOnly2: false, title: name, isPass: false),
              10.heightBox,
              customTextField(controller: controller.oldpassController,hint: passwordHint, readOnly2: false, title: oldpass, isPass: true),
              10.heightBox,
              customTextField(controller: controller.newpassController,hint: passwordHint, readOnly2: false, title: newpass, isPass: true),
              20.heightBox,
              controller.isloading.value ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.yellow),
              ): SizedBox(
                width: context.screenWidth - 60,
                child: ourButton(color:  Color.fromRGBO(4, 84, 158, 30), onPress: () async {


                  controller.isloading(true);

                  //if image is not selected
                  if (controller.profileImgPath.value.isNotEmpty) {
                    await controller.uploadProfileImage();
                  } else {
                    controller.profileImageLink = data['imageUrl'];
                  }


                  //if old password matches DB
                  if (data['password'] == controller.oldpassController.text) {
                    await controller.changeAuthPassword(
                      email: data['email'],
                      password: controller.oldpassController.text,
                      newpassword: controller.newpassController.text,
                    );

                    await controller.updateProfile(
                      imgUrl: controller.profileImageLink,
                      name: controller.nameController.text,
                      password: controller.newpassController.text
                    );
                    VxToast.show(context, msg: "Úpdated");
                  }
                  else{
                    VxToast.show(context, msg: "Wrong old password");
                    controller.isloading(false);
                  }



                  
                },textColor: Color.fromARGB(255,254, 240, 2),title: "Save")
              ),
            ],
          ).box.white.shadowSm.padding(EdgeInsets.all(16)).margin(EdgeInsets.only(top: 50, left: 12, right: 12)).rounded.make(),
        ),
      ),
    );
  }
}