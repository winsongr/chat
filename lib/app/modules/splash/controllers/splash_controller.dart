import 'dart:async';

import 'package:chat/app/routes/app_pages.dart';
import 'package:chat/app/utils/box.dart';
import 'package:chat/app/utils/exports.dart';

class SplashController extends GetxController {
  final count = 0.obs;

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



  void increment() => count.value++;
}
