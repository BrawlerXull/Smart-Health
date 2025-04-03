import 'package:get/get.dart';

import '../controllers/medi_buddy_controller.dart';

class MediBuddyBinding extends Bindings {
  @override
  void dependencies() {
    Get.find<MediBuddyController>();
  }
}
