import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_health/app/widgets/challenge_card.dart';
import 'package:smart_health/app/widgets/custom_clipper.dart';
import 'package:smart_health/app/data/utils/constants.dart';
import '../controllers/challenges_controller.dart';

class ChallengesView extends GetView<ChallengesController> {
  const ChallengesView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChallengesController());
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: Stack(
        children: [
          // Header background
          ClipPath(
            clipper: MyCustomClipper(clipType: ClipType.bottom),
            child: Container(
              color: Constants.lightBlue,
              height: Constants.headerHeight + statusBarHeight,
            ),
          ),
          Positioned(
            right: -45,
            top: -30,
            child: ClipOval(
              child: Container(
                color: Colors.black.withOpacity(0.05),
                height: 220,
                width: 220,
              ),
            ),
          ),

          // Body
          Padding(
            padding: EdgeInsets.only(
              top: 60,
              left: Constants.paddingSide,
              right: Constants.paddingSide,
              bottom: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Challenges",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
                SizedBox(height: 20),
                // Toggle buttons
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _toggleButton(
                        text: "🏆 Active",
                        isSelected: controller.showActive.value,
                        onTap: () => controller.showActive.value = true,
                      ),
                      const SizedBox(width: 12),
                      _toggleButton(
                        text: "✅ Completed",
                        isSelected: !controller.showActive.value,
                        onTap: () => controller.showActive.value = false,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Challenges list
                Expanded(
                  child: Obx(() {
                    final challenges = controller.showActive.value
                        ? controller.activeChallenges
                        : controller.completedChallenges;

                    if (challenges.isEmpty) {
                      return _emptyState(
                        controller.showActive.value
                            ? "No active challenges at the moment."
                            : "Complete challenges to see them here!",
                      );
                    }

                    return ListView.builder(
                      itemCount: challenges.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: ChallengeCard(
                          challenge: challenges[index],
                          isCompleted: !controller.showActive.value,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _toggleButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _emptyState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(message, textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}
