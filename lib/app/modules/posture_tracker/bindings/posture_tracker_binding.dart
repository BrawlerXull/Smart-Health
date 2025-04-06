import 'package:get/get.dart';

import '../controllers/posture_tracker_controller.dart';

class PostureTrackerBinding extends Bindings {
  @override
  void dependencies() {
    Get.find<PostureTrackerController>();
  }
}
