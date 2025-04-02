import 'package:get/get.dart';

class RemindersController extends GetxController {
  //TODO: Implement RemindersController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    print("Initialised reminders cotnroelrl");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
