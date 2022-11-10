import 'package:chat/app/routes/app_pages.dart';
import 'package:chat/assets.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: SizedBox(
            height: Get.height,
            width: Get.width,
            child: Stack(children: [
              Container(
                height: Get.height * 0.5,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Assets.images.backgroundPNG),
                        fit: BoxFit.fill)),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 30,
                      width: 80,
                      height: Get.height * 0.25,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(Assets.images.light1PNG))),
                      ),
                    ),
                    Positioned(
                      left: 140,
                      width: 80,
                      height: 150,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(Assets.images.light2PNG))),
                      ),
                    ),
                    Positioned(
                      right: 40,
                      top: 40,
                      width: 80,
                      height: 150,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(Assets.images.clockPNG))),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                width: Get.width,
                top: Get.height * 0.4,
                child: Obx(() => Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: Get.width * 0.8,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: Get.width * 0.8,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration:
                                      const BoxDecoration(border: Border()),
                                  child: TextField(
                                    onChanged: (v) {
                                      if (v.isNotEmpty) {
                                        controller.name.value = true;
                                      } else {
                                        controller.name.value = false;
                                      }
                                    },
                                    controller: controller.nameController.value,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Name",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                ),
                                Container(
                                  width: Get.width * 0.8,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration:
                                      const BoxDecoration(border: Border()),
                                  child: TextField(
                                    onChanged: (v) {
                                      if (v.isNotEmpty) {
                                        controller.email.value = true;
                                      } else {
                                        controller.email.value = false;
                                      }
                                    },
                                    controller:
                                        controller.emailController.value,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                ),
                                Container(
                                  width: Get.width * 0.8,
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    onChanged: (v) {
                                      if (v.isNotEmpty) {
                                        controller.password.value = true;
                                      } else {
                                        controller.password.value = false;
                                      }
                                    },
                                    controller:
                                        controller.passwordController.value,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                              height: 30,
                              child: controller.loading.value
                                  ? CircularProgressIndicator()
                                  : SizedBox()),
                          InkWell(
                            onTap: controller.loading.value == false
                                ? () async {
                                    if (controller.email.value &&
                                        controller.name.value &&
                                        controller.password.value) {
                                      await controller.register();
                                    }
                                  }
                                : null,
                            child: Container(
                              width: Get.width * 0.8,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                    colors: controller.email.value &&
                                            controller.password.value
                                        ? [
                                            Color.fromRGBO(143, 148, 251, 1),
                                            Color.fromRGBO(143, 148, 251, .6),
                                          ]
                                        : [Colors.grey, Colors.black38]),
                              ),
                              child: const Center(
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            child: Text("Tap to Login"),
                            onTap: () {
                              Get.offAndToNamed(Routes.LOGIN);
                            },
                          )
                        ],
                      ),
                    )),
              ),
            ]),
          ),
        )));
  }
}
