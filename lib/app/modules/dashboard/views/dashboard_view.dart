import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_health/app/data/models/achievement.dart';
import 'package:smart_health/app/data/models/challenge.dart';
import 'package:smart_health/app/data/models/wellness_metrics.dart';
import 'package:smart_health/app/data/models/wellness_alert.dart';
import 'package:smart_health/app/widgets/achievement_card.dart';
import 'package:smart_health/app/widgets/challenge_card.dart';
import 'package:smart_health/app/widgets/health_summary_card.dart';
import 'package:smart_health/app/widgets/next_reminder_card.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final wellnessMetrics = WellnessMetrics(
      hydrationLevel: 60,
      stepCount: 2300,
      mindfulnessMinutes: 12,
      postureCheckTimestamp: DateTime.now(),
      sleepHours: 7,
      caloriesBurned: 230,
      heartRate: 78.5,
      stressLevel: 5,
    );

    final nextReminder = WellnessAlert(
      alertId: "1",
      alertTitle: "Hydration Alert 💧",
      alertMessage: "Stay refreshed! Time for a water break.",
      category: AlertCategory.hydration,
      interval: AlertInterval.hourly,
      alertTime: const TimeOfDay(hour: 10, minute: 0),
      isEnabled: true,
    );

    final unlockedAchievements = [
      Achievement(
        id: "a1",
        title: "🏅 Step Pro",
        description: "You hit 10,000 steps in a day! Keep moving! 🚶",
        points: 50,
        isAchieved: true,
      ),
    ];

    final activeChallenges = [
      Challenge(
        challengeId: "c2",
        challengeTitle: "🧘 Mindfulness Marathon",
        challengeDescription: "Commit to 10 minutes of meditation every day for a week. Stay mindful! ✨",
        goalProgress: 7,
        achievedProgress: 3,
        rewardPoints: 100,
      ),
    ];

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header (Stats)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("🌟 Total Points: 150", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("🔥 Streak: 5 Days", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Upcoming Reminder
                  Text("⏰ Next Wellness Check-in", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  NextReminderCard(reminder: nextReminder, onComplete: () => print("Reminder completed")),

                  const SizedBox(height: 24),

                  // Health Stats
                  Text("📊 Today's Wellness Summary", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  HealthSummaryCard(healthData: wellnessMetrics),

                  const SizedBox(height: 24),

                  // Achievements Unlocked
                  Text("🏆 Recent Achievements", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  unlockedAchievements.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: unlockedAchievements.length,
                          itemBuilder: (context, index) => AchievementCard(achievement: unlockedAchievements[index]),
                        )
                      : Center(child: Text("No achievements yet! Complete tasks to unlock rewards 🎯")),

                  const SizedBox(height: 24),

                  // Active Challenges
                  Text("🚀 Ongoing Challenges", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  activeChallenges.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: activeChallenges.length,
                          itemBuilder: (context, index) => ChallengeCard(challenge: activeChallenges[index]),
                        )
                      : Center(child: Text("No active challenges. Take on a new challenge today! 💪")),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
