import 'dart:convert';
import 'package:chat/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;

import 'package:chat/app/data/api.dart';
import 'package:chat/app/data/models/id_model.dart';
import 'package:chat/app/utils/box.dart';
import 'package:chat/app/utils/exports.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final nameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final RxBool loading = false.obs;
  RxBool email = false.obs;
  RxBool password = false.obs;
  RxBool name = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  register() async {
    loading.value = true;
    var signup = await signUp();
    if (signup != null) {
      Box box = Box();
      box.boxWrite(signup.insertedId);
      print(box.boxread());
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
              "Failed to Register",
              style: Get.theme.textTheme.titleMedium!
                  .copyWith(color: Colors.red[500]),
            ),
          ],
        ),
      )));
    }
    loading.value = false;
  }

  Future<IdModel?> signUp() async {
    var url = Uri.parse(ApiConst.signup);
    Map data = {
      "name": nameController.value.text.trim(),
      "email": emailController.value.text.trim(),
      "password": passwordController.value.text.trim(),
    };
    var body = json.encode(data);
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200 | 201) {
      var resdata = json.decode(response.body);
      var res = IdModel.fromJson(resdata['data']['data']);
      return res;
    } else {
      return null;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    nameController.value.clear();
    passwordController.value.clear();
    emailController.value.clear();
    super.dispose();
  }

  @override
  void onClose() {
    print("close");
    super.onClose();
  }
}
