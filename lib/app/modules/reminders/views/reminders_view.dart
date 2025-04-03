import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smart_health/app/widgets/alert_list_item.dart';

import '../controllers/reminders_controller.dart';

class RemindersView extends GetView<RemindersController> {
  const RemindersView({super.key});
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminders'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {

            },
          ),
        ],
      ),
      body: controller.reminders.isEmpty
          ? const Center(
              child: Text('No reminders yet. Add one to get started!'),
            )
          : ListView.builder(
              itemCount: controller.reminders.length,
              itemBuilder: (context, index) {
                final reminder = controller.reminders[index];
                return AlertListItem(
                  reminder: reminder,
                  onToggle: () {
                    controller.toggleReminderActive(reminder.alertId);
                  },
                  onEdit: () {
                   
                  },
                  onDelete: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Delete Reminder'),
                        content: Text('Are you sure you want to delete "${reminder.alertTitle}"?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              controller.deleteReminder(reminder.alertId);
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
            ),
    );
  }
}
