import 'package:get/get.dart';
class LeaderboardController extends GetxController {
  var selectedTab = "Daily".obs;

  List<Map<String, dynamic>> getLeaderboardData() {
    if (selectedTab.value == "Daily") {
      return List.generate(10, (index) => {"name": "User $index", "points": (10 - index) * 100});
    } else if (selectedTab.value == "Weekly") {
      return List.generate(10, (index) => {"name": "User $index", "points": (10 - index) * 700});
    } else {
      return List.generate(10, (index) => {"name": "User $index", "points": (10 - index) * 3000});
    }
  }
}