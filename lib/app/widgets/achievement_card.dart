import 'package:flutter/material.dart';
import 'package:smart_health/app/data/models/achievement.dart';

class AchievementCard extends StatelessWidget {
  final Achievement achievement;
  final bool isLocked;

  const AchievementCard({
    super.key,
    required this.achievement,
    this.isLocked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isLocked ? 1 : 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: isLocked ? Colors.grey[200] : Colors.white,
      shadowColor: isLocked ? Colors.grey[300] : Colors.blueAccent.withOpacity(0.3),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            // Icon Container
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                gradient: isLocked
                    ? null
                    : LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary.withOpacity(0.6),
                          Theme.of(context).colorScheme.primary.withOpacity(0.9),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                color: isLocked ? Colors.grey[400] : null,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                  isLocked ? Icons.lock : Icons.emoji_events,
                  size: 34,
                  color: isLocked ? Colors.grey[600] : Colors.white,
                ),

            ),

            const SizedBox(width: 16),

            // Achievement Title & Description
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    achievement.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isLocked ? Colors.grey[600] : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    achievement.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: isLocked ? Colors.grey[500] : Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),

            // Points & Status Container
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    gradient: isLocked
                        ? null
                        : LinearGradient(
                            colors: [
                              Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                              Theme.of(context).colorScheme.secondary,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                    color: isLocked ? Colors.grey[300] : null,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star,
                        size: 18,
                        color: isLocked ? Colors.grey[600] : Colors.white,
                      ),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Unlocked 🎉',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
