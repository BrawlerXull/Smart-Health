import 'package:get/get.dart';

import '../controllers/challenges_controller.dart';

class ChallengesBinding extends Bindings {
  @override
  void dependencies() {
    Get.find<ChallengesController>();
  }
}
