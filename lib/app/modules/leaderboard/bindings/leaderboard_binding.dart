import 'package:get/get.dart';

import '../controllers/leaderboard_controller.dart';

class LeaderboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.find<LeaderboardController>(

    );
  }
}
