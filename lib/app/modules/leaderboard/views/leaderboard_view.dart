import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/leaderboard_controller.dart';

import 'package:flutter/material.dart';

class ColorConsts {
  static const background = Colors.white;
  static const whiteCl = Colors.white;
  static const bluePrimary = Color(0xFF438AAC);
  static const lightGrey = Color(0xffeeeeee);
  static const greenAccent = Color(0xffC3DF17);
  static const yellowAccent = Color(0xffEFC800);
  static const orangeAccent = Color(0xffEFC800);
  static const orangeCl = Color(0xffFF964F);
  static const redAccent = Color(0xffFF6961);
  static const tealPopAccent = Color(0xFF30C3D5);
  static const blackText = Colors.black87;
  static const greySubtitle = Colors.grey;
  static Color whiteOpacity15 = ColorConsts.whiteCl.withOpacity(0.15);
  static Color greyOpacity02 = Colors.grey.withOpacity(0.2);
  static const transparent = Colors.transparent;
  static const Color greyLight = Color(0xFFE0E0E0);
  static const Color grey600 = Color(0xFF757575);
  static const Color black87 = Color(0xDD000000);
}

class LeaderboardView extends GetView<LeaderboardController> {
  const LeaderboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leaderboard')),
      body: Column(
        children: [
          const SizedBox(height: 16),

          // Toggle Switch for Daily, Weekly, Monthly
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: ["Daily", "Weekly", "Monthly"]
                    .map((label) => _toggleButton(
                          text: label,
                          isSelected: controller.selectedTab.value == label,
                          onTap: () => controller.selectedTab.value = label,
                        ))
                    .toList(),
              )),

          const SizedBox(height: 16),

          // Leaderboard List
          Expanded(
            child: Obx(() {
              final leaderboardData = controller.getLeaderboardData();
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: leaderboardData.length,
                itemBuilder: (context, index) =>
                    _buildLeaderboardItem(index + 1),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _toggleButton(
      {required String text,
      required bool isSelected,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueAccent : Colors.grey[300],
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

  
Widget _buildLeaderboardItem(int rank) {
  IconData rankIcon;
  Color rankColor;

  // Assigning medal icons for top 3 positions
  switch (rank) {
    case 1:
      rankIcon = Icons.emoji_events;
      rankColor = Colors.amber;
      break;
    case 2:
      rankIcon = Icons.emoji_events;
      rankColor = Colors.grey;
      break;
    case 3:
      rankIcon = Icons.emoji_events;
      rankColor = Colors.brown;
      break;
    default:
      rankIcon = Icons.star_border;
      rankColor = Colors.blueGrey;
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        // Rank Icon
        CircleAvatar(
          backgroundColor: rankColor,
          child: Icon(rankIcon, color: Colors.white),
        ),
        const SizedBox(width: 12),

        // Username
        Text(
          'User $rank',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),

        const Spacer(),

        // Streak
        Row(
          children: [
            const Icon(Icons.local_fire_department, color: Colors.orange, size: 20),
            const SizedBox(width: 4),
            Text(
              '${rank + 2}🔥',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),

        const SizedBox(width: 16),

        // Points
        Text(
          '${(11 - rank) * 100} pts',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

}
