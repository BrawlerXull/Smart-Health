import 'package:flutter/material.dart';
import 'package:smart_health/app/data/models/wellness_alert.dart';

class AlertListItem extends StatelessWidget {
  final WellnessAlert reminder;
  final VoidCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const AlertListItem({
    super.key,
    required this.reminder,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(reminder.alertTitle),
      direction: DismissDirection.horizontal,
      background: _buildSlideBackground(Colors.green, Icons.check, "Activate/Deactivate", Alignment.centerLeft),
      secondaryBackground: _buildSlideBackground(Colors.red, Icons.delete, "Delete", Alignment.centerRight),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          onToggle();
        } else {
          onDelete();
        }
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon + Title + Message Row
              Row(
                children: [
                  _iconWithBackground(reminder.category, reminder.isEnabled),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reminder.alertTitle,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: reminder.isEnabled ? Colors.black : Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          reminder.alertMessage,
                          style: TextStyle(
                            fontSize: 14,
                            color: reminder.isEnabled ? Colors.grey[700] : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Alert Time & Interval Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _infoTile(Icons.access_time, reminder.alertTime.format(context), reminder.isEnabled),
                  _infoTile(Icons.repeat, _getIntervalText(reminder.interval), reminder.isEnabled),
                ],
              ),
              const SizedBox(height: 10),

             
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlideBackground(Color color, IconData icon, String label, Alignment alignment) {
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: color,
      child: Row(
        mainAxisAlignment: alignment == Alignment.centerLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _infoTile(IconData icon, String text, bool isEnabled) {
    return Row(
      children: [
        Icon(icon, size: 16, color: isEnabled ? Colors.grey[700] : Colors.grey[500]),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(fontSize: 14, color: isEnabled ? Colors.grey[800] : Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _iconWithBackground(AlertCategory category, bool isEnabled) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isEnabled
            ? _getAlertColor(category).withOpacity(0.15)
            : Colors.grey.withOpacity(0.2), // Muted color when disabled
        shape: BoxShape.circle,
      ),
      child: Icon(
        _getAlertIcon(category),
        color: isEnabled ? _getAlertColor(category) : Colors.grey,
        size: 28,
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
