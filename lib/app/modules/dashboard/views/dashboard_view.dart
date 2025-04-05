import 'dart:math';

import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:get/get.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:smart_health/app/data/models/achievement.dart';
import 'package:smart_health/app/data/models/challenge.dart';

import 'package:smart_health/app/modules/reminders/controllers/reminders_controller.dart';
import 'package:smart_health/app/widgets/achievement_card.dart';
import 'package:smart_health/app/widgets/challenge_card.dart';
import 'package:smart_health/app/widgets/next_reminder_card.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    List<Color> primaryG = [Color(0xff9DCEFF), const Color(0xff92A3FD)];
    List<Color> secondaryG = [const Color(0xffEEA4CE), const Color(0xffC58BF2)];

    final RemindersController remindersController =
        Get.find<RemindersController>();

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
        challengeDescription:
            "Commit to 10 minutes of meditation every day for a week. Stay mindful! ✨",
        goalProgress: 7,
        achievedProgress: 3,
        rewardPoints: 100,
      ),
    ];
    List waterArr = [
      {"title": "6am - 8am", "subtitle": "600ml"},
      {"title": "9am - 11am", "subtitle": "500ml"},
      {"title": "11am - 2pm", "subtitle": "1000ml"},
      {"title": "2pm - 4pm", "subtitle": "700ml"},
      {"title": "4pm - now", "subtitle": "900ml"},
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
                  const SizedBox(height: 20),
                  Text("⏰ Streak Tracker",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  GitHubHeatMap(),

                  const SizedBox(height: 20),

                  // Upcoming Reminder
                  Text("⏰ Next Wellness Check-in",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  NextReminderCard(
                      reminder: remindersController.nextReminder.value,
                      onComplete: () => print("Reminder completed")),

                  const SizedBox(height: 24),

                  // Health Stats
                  Text("📊 Today's Wellness Summary",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  // HealthSummaryCard(healthData: wellnessMetrics),

                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: Get.width * 0.95,
                          padding: const EdgeInsets.symmetric(
                              vertical: 25, horizontal: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: const [
                                BoxShadow(color: Colors.black12, blurRadius: 2)
                              ]),
                          child: Row(
                            children: [
                              SimpleAnimationProgressBar(
                                height: Get.width * 0.85,
                                width: Get.width * 0.07,
                                backgroundColor: Colors.grey.shade100,
                                foregrondColor: Colors.purple,
                                ratio: 0.5,
                                direction: Axis.vertical,
                                curve: Curves.fastLinearToSlowEaseIn,
                                duration: const Duration(seconds: 3),
                                borderRadius: BorderRadius.circular(15),
                                gradientColor: LinearGradient(
                                    colors: primaryG,
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Water Intake",
                                    style: TextStyle(
                                        color: const Color(0xff1D1617),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  ShaderMask(
                                    blendMode: BlendMode.srcIn,
                                    shaderCallback: (bounds) {
                                      return LinearGradient(
                                              colors: primaryG,
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight)
                                          .createShader(Rect.fromLTRB(0, 0,
                                              bounds.width, bounds.height));
                                    },
                                    child: Text(
                                      "4 Liters",
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.7),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Real time updates",
                                    style: TextStyle(
                                      color: const Color(0xff786F72),
                                      fontSize: 12,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: waterArr.map((wObj) {
                                      var isLast = wObj == waterArr.last;
                                      return Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4),
                                                width: 10,
                                                height: 10,
                                                decoration: BoxDecoration(
                                                  color: const Color(0xffEEA4CE)
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                              if (!isLast)
                                                DottedDashedLine(
                                                    height: Get.width * 0.078,
                                                    width: 0,
                                                    dashColor:
                                                        const Color(0xffEEA4CE)
                                                            .withOpacity(0.5),
                                                    axis: Axis.vertical)
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                wObj["title"].toString(),
                                                style: TextStyle(
                                                  color:
                                                      const Color(0xff786F72),
                                                  fontSize: 10,
                                                ),
                                              ),
                                              ShaderMask(
                                                blendMode: BlendMode.srcIn,
                                                shaderCallback: (bounds) {
                                                  return LinearGradient(
                                                          colors: secondaryG,
                                                          begin: Alignment
                                                              .centerLeft,
                                                          end: Alignment
                                                              .centerRight)
                                                      .createShader(
                                                          Rect.fromLTRB(
                                                              0,
                                                              0,
                                                              bounds.width,
                                                              bounds.height));
                                                },
                                                child: Text(
                                                  wObj["subtitle"].toString(),
                                                  style: TextStyle(
                                                      color: Colors.white
                                                          .withOpacity(0.7),
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      );
                                    }).toList(),
                                  )
                                ],
                              ))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.05,
                      ),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: double.maxFinite,
                            height: Get.width * 0.45,
                            padding: const EdgeInsets.symmetric(
                                vertical: 25, horizontal: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black12, blurRadius: 2)
                                ]),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Steps",
                                    style: TextStyle(
                                        color: const Color(0xff1D1617),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  ShaderMask(
                                    blendMode: BlendMode.srcIn,
                                    shaderCallback: (bounds) {
                                      return LinearGradient(
                                              colors: primaryG,
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight)
                                          .createShader(Rect.fromLTRB(0, 0,
                                              bounds.width, bounds.height));
                                    },
                                    child: Text(
                                      "8h 20m",
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.7),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14),
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      width: Get.width * 0.2,
                                      height: Get.width * 0.2,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            width: Get.width * 0.15,
                                            height: Get.width * 0.15,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  colors: primaryG),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Get.width * 0.075),
                                            ),
                                            child: FittedBox(
                                              child: Text(
                                                "2300 Steps\nleft",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11),
                                              ),
                                            ),
                                          ),
                                          SimpleCircularProgressBar(
                                            progressStrokeWidth: 10,
                                            backStrokeWidth: 10,
                                            progressColors: primaryG,
                                            backColor: Colors.grey.shade100,
                                            valueNotifier: ValueNotifier(50),
                                            startAngle: -180,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                          SizedBox(
                            height: Get.width * 0.05,
                          ),
                          Container(
                            width: double.maxFinite,
                            height: Get.width * 0.45,
                            padding: const EdgeInsets.symmetric(
                                vertical: 25, horizontal: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black12, blurRadius: 2)
                                ]),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Calories",
                                    style: TextStyle(
                                        color: const Color(0xff1D1617),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  ShaderMask(
                                    blendMode: BlendMode.srcIn,
                                    shaderCallback: (bounds) {
                                      return LinearGradient(
                                              colors: primaryG,
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight)
                                          .createShader(Rect.fromLTRB(0, 0,
                                              bounds.width, bounds.height));
                                    },
                                    child: Text(
                                      "760 kCal",
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.7),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14),
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      width: Get.width * 0.2,
                                      height: Get.width * 0.2,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            width: Get.width * 0.15,
                                            height: Get.width * 0.15,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  colors: primaryG),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Get.width * 0.075),
                                            ),
                                            child: FittedBox(
                                              child: Text(
                                                "230kCal\nleft",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11),
                                              ),
                                            ),
                                          ),
                                          SimpleCircularProgressBar(
                                            progressStrokeWidth: 10,
                                            backStrokeWidth: 10,
                                            progressColors: primaryG,
                                            backColor: Colors.grey.shade100,
                                            valueNotifier: ValueNotifier(50),
                                            startAngle: -180,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ]),
                          ),
                        ],
                      ))
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Achievements Unlocked
                  Text("🏆 Recent Achievements",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  unlockedAchievements.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: unlockedAchievements.length,
                          itemBuilder: (context, index) => AchievementCard(
                              achievement: unlockedAchievements[index]),
                        )
                      : Center(
                          child: Text(
                              "No achievements yet! Complete tasks to unlock rewards 🎯")),

                  const SizedBox(height: 24),

                  // Active Challenges
                  Text("🚀 Ongoing Challenges",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  activeChallenges.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: activeChallenges.length,
                          itemBuilder: (context, index) =>
                              ChallengeCard(challenge: activeChallenges[index]),
                        )
                      : Center(
                          child: Text(
                              "No active challenges. Take on a new challenge today! 💪")),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GitHubHeatMap extends StatelessWidget {
  // Function to generate random streak data for a year
  Map<DateTime, int> generateRandomData() {
    final Random random = Random();
    final Map<DateTime, int> data = {};
    final int currentYear = DateTime.now().year;
    final DateTime startDate = DateTime(currentYear, 1, 1);
    final DateTime endDate = DateTime.now();

    // Total days in the period
    final int totalDays = endDate.difference(startDate).inDays + 1;

    // Initially, set low activity (e.g., 0 or 1) for each day
    for (int i = 0; i < totalDays; i++) {
      final date = startDate.add(Duration(days: i));
      data[date] = random.nextBool() ? 0 : 1;
    }

    // Define number of streaks to generate
    int streakCount = 5;

    for (int i = 0; i < streakCount; i++) {
      // Randomly pick a starting day within the period
      int streakStartOffset = random.nextInt(totalDays);
      // Random streak length between 3 and 10 days
      int streakLength = 3 + random.nextInt(8);

      // Loop over the streak period and assign a higher value
      for (int j = 0; j < streakLength; j++) {
        int dayOffset = streakStartOffset + j;
        // Ensure we do not exceed the period
        if (dayOffset < totalDays) {
          final date = startDate.add(Duration(days: dayOffset));
          // Assign a random high value between 3 and 7
          data[date] = 3 + random.nextInt(5);
        }
      }
    }

    return data;
  }

  GitHubHeatMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<DateTime, int> datasets = generateRandomData();

    return HeatMap(
      startDate: DateTime(DateTime.now().year, 1, 1),
      endDate: DateTime.now(),
      datasets: datasets,
      colorMode: ColorMode.opacity,
      defaultColor: Colors.grey[300]!,
      textColor: Colors.black87,
      // Customize the color thresholds using darker shades:
      colorsets: {
        1: Colors.green[700]!,
        3: Colors.green[800]!,
        5: Colors.green[800]!,
        7: Colors.green[900]!,
      },
      showColorTip: false,
      scrollable: true,
    );
  }
}
