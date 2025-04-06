import 'package:get/get.dart';
import 'package:smart_health/app/data/service/posture_monitoring_service.dart';
import 'package:smart_health/app/modules/challenges/controllers/challenges_controller.dart';
import 'package:smart_health/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:smart_health/app/modules/fitbit/controllers/fitbit_controller.dart';

import 'package:smart_health/app/modules/leaderboard/controllers/leaderboard_controller.dart';
import 'package:smart_health/app/modules/medication/controllers/medication_controller.dart';
import 'package:smart_health/app/modules/medication/views/medication_view.dart';
import 'package:smart_health/app/modules/posture_tracker/controllers/posture_tracker_controller.dart';
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
    Get.put<LeaderboardController>(LeaderboardController());
    Get.put<PostureTrackerController>(PostureTrackerController());
    Get.put<FitbitController>(FitbitController());
    Get.put<MedicationController>(MedicationController());

  }
}
