import 'package:flutter/material.dart';
import 'package:smart_health/app/data/models/achievement.dart';
import 'package:smart_health/app/widgets/custom_clipper.dart';
import 'package:smart_health/app/data/utils/constants.dart';

class AchievementCard extends StatelessWidget {
  final Achievement achievement;
  final bool isLocked;

  const AchievementCard({
    Key? key,
    required this.achievement,
    this.isLocked = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final secondaryColor = Theme.of(context).colorScheme.secondary;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            left: -40,
            top: -40,
            child: ClipPath(
              clipper: MyCustomClipper(clipType: ClipType.semiCircle),
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: (isLocked ? Colors.grey[300] : primaryColor.withOpacity(0.1)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: isLocked ? Colors.grey[400] : primaryColor,
                  ),
                  child: Icon(
                    isLocked ? Icons.lock : Icons.emoji_events,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        achievement.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isLocked ? Colors.grey[600] : Constants.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        achievement.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          color: isLocked ? Colors.grey[500] : Constants.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: isLocked ? Colors.grey[300] : secondaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, size: 18, color: isLocked ? Colors.grey[600] : Colors.white),
                          const SizedBox(width: 5),
                          Text(
                            '${achievement.points}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isLocked ? Colors.grey[600] : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!isLocked)
                      const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          'Unlocked 🎉',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Constants.textPrimary,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
