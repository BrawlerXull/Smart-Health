import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_health/app/modules/onboarding/views/components/care_view.dart';
import 'package:smart_health/app/modules/onboarding/views/components/center_next_button.dart';
import 'package:smart_health/app/modules/onboarding/views/components/mood_diary_vew.dart';
import 'package:smart_health/app/modules/onboarding/views/components/relax_view.dart';
import 'package:smart_health/app/modules/onboarding/views/components/splash_view.dart';
import 'package:smart_health/app/modules/onboarding/views/components/top_back_skip_view.dart';
import 'package:smart_health/app/modules/onboarding/views/components/welcome_view.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7EBE1),
      body: ClipRect(
        child: Stack(
          children: [
            SplashView(animationController: controller.animationController),
            RelaxView(animationController: controller.animationController),
            CareView(animationController: controller.animationController),
            MoodDiaryVew(animationController: controller.animationController),
            WelcomeView(animationController: controller.animationController),
            TopBackSkipView(
              onBackClick: controller.onBackClick,
              onSkipClick: controller.onSkipClick,
              animationController: controller.animationController,
            ),
            CenterNextButton(
              animationController: controller.animationController,
              onNextClick: controller.onNextClick,
            ),
          ],
        ),
      ),
    );
  }
}
