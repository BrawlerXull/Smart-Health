import 'package:get/get.dart';

class HomeController extends GetxController {
  // Observable index for navigation
  RxInt selectedIndex = 0.obs;

  // Method to change tab index
  void changeIndex(int index) {
    selectedIndex.value = index;
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("Initialised home cotnroelrl");
  }
}
