import 'package:get/get.dart';
import 'package:smart_health/app/modules/challenges/controllers/challenges_controller.dart';
import 'package:smart_health/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:smart_health/app/modules/reminders/controllers/reminders_controller.dart';
import 'package:smart_health/app/modules/medi_buddy/controllers/medi_buddy_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.put<DashboardController>(DashboardController());
    Get.put<RemindersController>(RemindersController());
    Get.put<ChallengesController>(ChallengesController());
    Get.put<MediBuddyController>(MediBuddyController());

  }
}
