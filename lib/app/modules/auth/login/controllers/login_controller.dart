import 'dart:convert';

import 'package:chat/app/data/api.dart';
import 'package:chat/app/data/models/user_model.dart';
import 'package:chat/app/routes/app_pages.dart';
import 'package:chat/app/utils/box.dart';
import 'package:chat/app/utils/exports.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  RxBool isValid = false.obs;
  RxBool email = false.obs;
  RxBool password = false.obs;
  @override
  void onInit() {
    print("init");

    super.onInit();
  }

  login() async {
    var sign = await signin();

    if (sign != null) {
      Box box = Box();
      box.boxWrite(sign.id);
      Get.offAndToNamed(Routes.SPLASH);
    } else {
      Get.dialog(Center(
          child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30)),
        width: Get.width * 0.6,
        height: Get.height * 0.1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline_outlined,
              color: Colors.red,
              size: 30,
            ),
            Text(
              "Invalid Email or Password",
              style: Get.theme.textTheme.titleMedium!
                  .copyWith(color: Colors.red[500]),
            ),
          ],
        ),
      )));
    }
  }

  Future<UserModel?> signin() async {
    var url = Uri.parse(ApiConst.signin);
    Map data = {
      'name': ' ',
      "email": emailController.value.text.trim(),
      "password": passwordController.value.text.trim()
    };
    var body = json.encode(data);
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      var resdata = json.decode(response.body);
      var res = UserModel.fromJson(resdata['data']['data']);

      return res;
    } else {
      return null;
    }
  }

  @override
  void dispose() {
    emailController.value.clear();
    passwordController.value.clear();
    super.dispose();
  }
}
