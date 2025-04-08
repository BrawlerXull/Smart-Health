import 'package:flutter/material.dart';
import 'package:smart_health/app/data/models/challenge.dart';
import 'package:smart_health/app/widgets/custom_clipper.dart';
import 'package:smart_health/app/data/utils/constants.dart';

class ChallengeCard extends StatelessWidget {
  final Challenge challenge;
  final bool isCompleted;

  const ChallengeCard({
    super.key,
    required this.challenge,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative clipped shape
          Positioned(
            top: -40,
            right: -40,
            child: ClipPath(
              clipper: MyCustomClipper(clipType: ClipType.semiCircle),
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? Colors.green.withOpacity(0.1)
                      : theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Header with icon
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: isCompleted
                          ? Colors.green.withOpacity(0.2)
                          : theme.colorScheme.primary.withOpacity(0.2),
                      child: Icon(
                        isCompleted ? Icons.check_circle : Icons.flag,
                        color: isCompleted ? Colors.green : theme.colorScheme.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            challenge.challengeTitle,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Constants.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            challenge.challengeDescription,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                /// Progress & Points Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Progress: ${challenge.achievedProgress}/${challenge.goalProgress}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: isCompleted ? Colors.green[700] : Constants.textPrimary,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        gradient: isCompleted
                            ? const LinearGradient(colors: [Colors.green, Colors.lightGreen])
                            : LinearGradient(
                                colors: [
                                  theme.colorScheme.secondary.withOpacity(0.5),
                                  theme.colorScheme.secondary,
                                ],
                              ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star, size: 14, color: Colors.white),
                          const SizedBox(width: 4),
                          Text(
                            '${challenge.rewardPoints}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                /// Progress Bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: challenge.progressPercentage,
                    minHeight: 8,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isCompleted ? Colors.green : theme.colorScheme.primary,
                    ),
                    backgroundColor: Colors.grey[200],
                  ),
                ),

                /// Completed Badge
                if (isCompleted)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(Icons.check_circle, size: 16, color: Colors.green),
                        const SizedBox(width: 6),
                        Text(
                          'Completed!',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[700],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
