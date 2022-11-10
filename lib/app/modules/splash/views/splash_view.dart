import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async => await controller.splashTimer(),
    );
    return const Scaffold(
        body: SafeArea(
      child: Center(
        child:FlutterLogo(size: 50,)
      ),
    ));
  }
}
