import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_health/app/routes/app_pages.dart';

class OnboardingController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void onInit() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    );
    animationController.animateTo(0.0);
    super.onInit();
  }

  void onSkipClick() {
    animationController.animateTo(0.8,
        duration: const Duration(milliseconds: 1200));
  }

  void onBackClick() {
    final value = animationController.value;
    if (value <= 0.2) {
      animationController.animateTo(0.0);
    } else if (value <= 0.4) {
      animationController.animateTo(0.2);
    } else if (value <= 0.6) {
      animationController.animateTo(0.4);
    } else if (value <= 0.8) {
      animationController.animateTo(0.6);
    } else {
      animationController.animateTo(0.8);
    }
  }

  void onNextClick() {
    final value = animationController.value;
    if (value <= 0.2) {
      animationController.animateTo(0.4);
    } else if (value <= 0.4) {
      animationController.animateTo(0.6);
    } else if (value <= 0.6) {
      animationController.animateTo(0.8);
    } else if (value <= 0.8) {
      _signUpClick();
    }
  }

  void _signUpClick() {
    Get.toNamed(Routes.HOME);
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
