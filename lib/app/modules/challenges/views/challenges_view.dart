import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_health/app/widgets/challenge_card.dart';
import '../controllers/challenges_controller.dart';

class ChallengesView extends GetView<ChallengesController> {
  const ChallengesView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChallengesController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Challenges'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Toggle Buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(
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
          ),

          // Challenges List
          Expanded(
            child: Obx(() {
              final challenges = controller.showActive.value
                  ? controller.activeChallenges
                  : controller.completedChallenges;
              return challenges.isEmpty
                  ? _emptyState(controller.showActive.value
                      ? "No active challenges at the moment."
                      : "Complete challenges to see them here!")
                  : ListView.builder(
                      padding: const EdgeInsets.all(16.0),
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
    );
  }

  Widget _toggleButton({required String text, required bool isSelected, required VoidCallback onTap}) {
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
