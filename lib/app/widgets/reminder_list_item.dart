import 'package:flutter/material.dart';
import 'package:smart_health/app/data/models/wellness_alert.dart';



class ReminderListItem extends StatelessWidget {
  final WellnessAlert reminder;
  final VoidCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ReminderListItem({
    super.key,
    required this.reminder,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getAlertColor(reminder.category).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getAlertIcon(reminder.category),
                    color: _getAlertColor(reminder.category),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reminder.alertTitle,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: reminder.isEnabled ? null : Colors.grey,
                        ),
                      ),
                      Text(
                        reminder.alertMessage,
                        style: TextStyle(
                          fontSize: 14,
                          color: reminder.isEnabled ? Colors.grey[600] : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: reminder.isEnabled,
                  onChanged: (_) => onToggle(),
                  activeColor: _getAlertColor(reminder.category),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      reminder.alertTime.format(context),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: reminder.isEnabled ? null : Colors.grey,
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
                      style: TextStyle(
                        fontSize: 14,
                        color: reminder.isEnabled ? null : Colors.grey,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: onEdit,
                      color: Colors.blue,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: onDelete,
                      color: Colors.red,
                    ),
                  ],
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

