import 'package:get/get.dart';

import '../controllers/reminders_controller.dart';

class RemindersBinding extends Bindings {
  @override
  void dependencies() {
    Get.find<RemindersController>();
  }
}
