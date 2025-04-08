import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_health/app/data/utils/constants.dart';
import 'package:smart_health/app/widgets/custom_clipper.dart';

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
    // Use existing Constants values as substitutes
    final background = Constants.lightBackground;
    final primary = Constants.lightAccent;
    final cardBackground = Constants.lightPrimary;
    final shadow = Colors.black;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: background,
      body: Stack(
        children: [
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
          Padding(
            padding: EdgeInsets.only(
              top: 80,
              left: 10,
              right: 10,
              bottom: 10,
            ),
            child: Column(
              children: [
                Text(
                  "Leaderboard",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
                const SizedBox(height: 16),
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: ["Daily", "Weekly", "Monthly"]
                          .map((label) => _toggleButton(
                                text: label,
                                isSelected:
                                    controller.selectedTab.value == label,
                                onTap: () =>
                                    controller.selectedTab.value = label,
                                primary: primary,
                                cardBackground: cardBackground,
                              ))
                          .toList(),
                    )),
                const SizedBox(height: 16),
                Expanded(
                  child: Obx(() {
                    final leaderboardData = controller.getLeaderboardData();
                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: leaderboardData.length,
                      itemBuilder: (context, index) => _buildLeaderboardCard(
                        index + 1,
                        primary,
                        cardBackground,
                        shadow,
                      ),
                    );
                  }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _toggleButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
    required Color primary,
    required Color cardBackground,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: isSelected ? primary : cardBackground,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Constants.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildLeaderboardCard(
    int rank,
    Color primary,
    Color cardBackground,
    Color shadow,
  ) {
    IconData rankIcon;
    Color rankColor;

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
        rankColor = primary;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 100,
      decoration: BoxDecoration(
        color: cardBackground,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: shadow.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            child: ClipPath(
              clipper: MyCustomClipper(clipType: ClipType.halfCircle),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: rankColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: rankColor,
                  child: Icon(rankIcon, color: Colors.white),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('User $rank',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Constants.textPrimary)),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.local_fire_department,
                              size: 16, color: Colors.orange),
                          const SizedBox(width: 4),
                          Text('${rank + 2} day streak',
                              style: TextStyle(
                                  fontSize: 14, color: Constants.textPrimary)),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  '${(11 - rank) * 100} pts',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Constants.textPrimary),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
