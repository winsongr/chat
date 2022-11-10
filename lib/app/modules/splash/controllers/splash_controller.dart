import 'dart:async';

import 'package:chat/app/routes/app_pages.dart';
import 'package:chat/app/utils/box.dart';
import 'package:chat/app/utils/exports.dart';

class SplashController extends GetxController {
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> splashTimer() async {
    Box box = Box();
    debugPrint(await box.boxread());

    Timer(const Duration(seconds: 3), () async {
      if (await box.boxread() == null) {
        Get.offAllNamed(Routes.LOGIN);
      } else {
        Get.offAllNamed(Routes.HOME);
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
