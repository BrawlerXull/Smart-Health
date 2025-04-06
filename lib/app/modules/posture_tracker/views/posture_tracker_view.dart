import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_health/app/widgets/custom_clipper.dart';
import 'package:smart_health/app/data/utils/constants.dart';
import '../controllers/posture_tracker_controller.dart';

class PostureTrackerView extends GetView<PostureTrackerController> {
  const PostureTrackerView({super.key});

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: Stack(
        children: [
          // Header
          ClipPath(
            clipper: MyCustomClipper(clipType: ClipType.bottom),
            child: Container(
              height: Constants.headerHeight + statusBarHeight + 50,
              color: Constants.lightBlue,
            ),
          ),
          Positioned(
            left: -40,
            top: -20,
            child: ClipOval(
              child: Container(
                color: Colors.black.withOpacity(0.05),
                height: 160,
                width: 160,
              ),
            ),
          ),
          SafeArea(
            child: Obx(
              () => SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Posture Tracker",
                     style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                              color: Colors.white
                          ),
                    ),
                    const SizedBox(height: 20),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Icon(
                              controller.postureValid.value
                                  ? Icons.check_circle_outline
                                  : Icons.warning_amber_rounded,
                              size: 40,
                              color: controller.postureValid.value ? Colors.green : Colors.red,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              controller.postureValid.value
                                  ? "Excellent Posture!"
                                  : "Needs Correction",
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Posture Score: 93",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // SizedBox(
                    //   height: 60,
                    //   width: 60,
                    //   child: Stack(
                    //     alignment: Alignment.center,
                    //     children: [
                    //       CircularProgressIndicator(
                    //         value: controller.qualityScore.value,
                    //         strokeWidth: 14,
                    //         backgroundColor: Colors.grey.shade300,
                    //         valueColor: AlwaysStoppedAnimation<Color>(
                    //           controller.postureValid.value ? Colors.green : Colors.red,
                    //         ),
                    //       ),
                    //       Text(
                    //         "68.8%",
                    //         style: const TextStyle(
                    //           fontSize: 22,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildMetricCard("Good Posture", "${controller.goodTime.value} min", Colors.green),
                        _buildMetricCard("Bad Posture", "27 min", Colors.red),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "📌 Posture Improvement Tips",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12),
                          ListTile(
                            leading: Icon(Icons.monitor_heart_outlined, color: Colors.teal),
                            title: Text("Adjust your screen to eye level to avoid slouching."),
                          ),
                          ListTile(
                            leading: Icon(Icons.accessibility_new, color: Colors.deepPurple),
                            title: Text("Engage your core while sitting to support your spine."),
                          ),
                          ListTile(
                            leading: Icon(Icons.schedule_outlined, color: Colors.orange),
                            title: Text("Stand up and stretch every 30 minutes."),
                          ),
                          ListTile(
                            leading: Icon(Icons.chair_alt_outlined, color: Colors.blue),
                            title: Text("Use a chair with lumbar support."),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String label, String time, Color color) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        child: Column(
          children: [
            Text(
              time,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
