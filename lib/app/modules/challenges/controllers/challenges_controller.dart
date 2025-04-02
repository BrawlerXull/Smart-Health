import 'package:get/get.dart';
import 'package:smart_health/app/data/models/challenge.dart';

class ChallengesController extends GetxController {
  final challenges = <Challenge>[
    Challenge(
      challengeId: "c1",
      challengeTitle: "🏃‍♂️ 5K Daily Run",
      challengeDescription: "Run 5 kilometers every day for a week.",
      goalProgress: 7,
      achievedProgress: 4,
      rewardPoints: 100,
    ),
    Challenge(
      challengeId: "c2",
      challengeTitle: "🧘‍♀️ 10-Min Meditation",
      challengeDescription: "Practice meditation for 10 minutes daily for a month.",
      goalProgress: 30,
      achievedProgress: 30,
      rewardPoints: 200,
    ),
    Challenge(
      challengeId: "c3",
      challengeTitle: "🚶 Walk 10,000 Steps",
      challengeDescription: "Complete 10,000 steps in a single day.",
      goalProgress: 1,
      achievedProgress: 1,
      rewardPoints: 50,
    ),
    Challenge(
      challengeId: "c4",
      challengeTitle: "💧 Hydration Goal",
      challengeDescription: "Drink 8 glasses of water daily for a week.",
      goalProgress: 7,
      achievedProgress: 5,
      rewardPoints: 70,
    ),
    Challenge(
      challengeId: "c5",
      challengeTitle: "💤 Sleep Well",
      challengeDescription: "Get at least 7 hours of sleep every night for a week.",
      goalProgress: 7,
      achievedProgress: 3,
      rewardPoints: 90,
    ),
    Challenge(
      challengeId: "c6",
      challengeTitle: "🍎 Healthy Eating",
      challengeDescription: "Eat 5 servings of fruits & veggies daily for 10 days.",
      goalProgress: 10,
      achievedProgress: 6,
      rewardPoints: 80,
    ),
    Challenge(
      challengeId: "c7",
      challengeTitle: "🏋️ Strength Training",
      challengeDescription: "Do strength training 3 times a week for a month.",
      goalProgress: 12,
      achievedProgress: 8,
      rewardPoints: 120,
    ),
    Challenge(
      challengeId: "c8",
      challengeTitle: "📵 Digital Detox",
      challengeDescription: "Avoid screens 30 minutes before bedtime for a week.",
      goalProgress: 7,
      achievedProgress: 4,
      rewardPoints: 60,
    ),
    Challenge(
      challengeId: "c9",
      challengeTitle: "🚴 Cycling Challenge",
      challengeDescription: "Cycle 50 km in a week.",
      goalProgress: 50,
      achievedProgress: 30,
      rewardPoints: 110,
    ),
    Challenge(
      challengeId: "c10",
      challengeTitle: "💨 Deep Breathing",
      challengeDescription: "Practice deep breathing exercises for 5 minutes daily.",
      goalProgress: 14,
      achievedProgress: 10,
      rewardPoints: 40,
    ),
  ].obs;

  // Observable to track the current tab (true = Active, false = Completed)
  var showActive = true.obs;

  List<Challenge> get activeChallenges =>
      challenges.where((c) => !c.isCompleted).toList();

  List<Challenge> get completedChallenges =>
      challenges.where((c) => c.isCompleted).toList();
}
