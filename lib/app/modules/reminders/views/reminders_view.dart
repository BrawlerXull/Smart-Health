import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_health/app/data/utils/constants.dart';
import 'package:smart_health/app/widgets/alert_list_item.dart';
import 'package:smart_health/app/widgets/custom_clipper.dart';

import '../controllers/reminders_controller.dart';

class RemindersView extends GetView<RemindersController> {
  const RemindersView({super.key});

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add reminder logic
        },
        child: const Icon(Icons.add),
      ),
      body: Stack(
        children: [
          ClipPath(
            clipper: MyCustomClipper(clipType: ClipType.bottom),
            child: Container(
              color: Constants.lightAccent,
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

          // Body content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                const Text(
                  "    Reminders",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Obx(() {
                    if (controller.reminders.isEmpty) {
                      return const Center(
                        child:
                            Text('No reminders yet. Add one to get started!'),
                      );
                    }

                    return ListView.builder(
                      itemCount: controller.reminders.length,
                      itemBuilder: (context, index) {
                        final reminder = controller.reminders[index];
                        return AlertListItem(
                          reminder: reminder,
                          onToggle: () {
                            controller.toggleReminderActive(reminder.alertId);
                          },
                          onEdit: () {
                            // Edit logic
                          },
                          onDelete: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Delete Reminder'),
                                content: Text(
                                  'Are you sure you want to delete "${reminder.alertTitle}"?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      controller
                                          .deleteReminder(reminder.alertId);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
