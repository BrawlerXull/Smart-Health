import 'package:flutter/material.dart';

import 'package:smart_health/app/data/models/wellness_alert.dart';


class NextReminderCard extends StatefulWidget {
  final WellnessAlert? reminder;
  final VoidCallback? onComplete;

  const NextReminderCard({super.key, this.reminder,this.onComplete});

  @override

  _NextReminderCardState createState() => _NextReminderCardState();
}

class _NextReminderCardState extends State<NextReminderCard> {
  @override
  Widget build(BuildContext context) {

    WellnessAlert? reminder = widget.reminder;

    if (reminder == null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.notifications_off,
                  size: 48,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 8),
                const Text(
                  'No upcoming reminders',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _getAlertColor(reminder.category).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getAlertIcon(reminder.category),
                    color: _getAlertColor(reminder.category),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reminder.alertTitle,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        reminder.alertMessage,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      reminder.alertTime.format(context),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.repeat, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      _getIntervalText(reminder.interval),
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _getAlertColor(reminder.category),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Complete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

 IconData _getAlertIcon(AlertCategory category) {
  switch (category) {
    case AlertCategory.hydration:
      return Icons.water_drop;
    case AlertCategory.postureCorrection:
      return Icons.accessibility_new;
    case AlertCategory.movement:
      return Icons.directions_walk;
    case AlertCategory.mindfulness:
      return Icons.self_improvement;
    case AlertCategory.custom:
      return Icons.notifications;
  }
}

Color _getAlertColor(AlertCategory category) {
  switch (category) {
    case AlertCategory.hydration:
      return Colors.blue;
    case AlertCategory.postureCorrection:
      return Colors.purple;
    case AlertCategory.movement:
      return Colors.green;
    case AlertCategory.mindfulness:
      return Colors.orange;
    case AlertCategory.custom:
      return Colors.grey;
  }
}

String _getIntervalText(AlertInterval interval) {
  switch (interval) {
    case AlertInterval.hourly:
      return 'Hourly';
    case AlertInterval.daily:
      return 'Daily';
    case AlertInterval.weekly:
      return 'Weekly';
    case AlertInterval.custom:
      return 'Custom';
  }
}

}