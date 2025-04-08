import 'package:flutter/material.dart';
import 'package:smart_health/app/data/models/wellness_alert.dart';
import 'package:smart_health/app/widgets/custom_clipper.dart';
import 'package:smart_health/app/data/utils/constants.dart';

class NextReminderCard extends StatelessWidget {
  final WellnessAlert? reminder;
  final VoidCallback? onComplete;

  const NextReminderCard({super.key, this.reminder, this.onComplete});

  @override
  Widget build(BuildContext context) {
    final secondaryColor = Theme.of(context).colorScheme.secondary;

    if (reminder == null) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            children: [
              Icon(Icons.notifications_off, size: 48, color: Colors.grey[400]),
              const SizedBox(height: 8),
              const Text(
                'No upcoming reminders',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.only(right: 15.0, top: 8, bottom: 8),
        // width: 260,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned(
              child: ClipPath(
                clipper: MyCustomClipper(clipType: ClipType.semiCircle),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: _getAlertColor(reminder!.category).withOpacity(0.1),
                  ),
                  height: 100,
                  width: 100,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        _getAlertIcon(reminder!.category),
                        color: secondaryColor,
                        size: 26,
                      ),
                      Text(
                        reminder!.alertTime.format(context),
                        style: TextStyle(
                          fontSize: 14,
                          color: Constants.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              reminder!.alertTitle,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Constants.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              reminder!.alertMessage,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Constants.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              _getIntervalText(reminder!.interval),
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      InkWell(
                        onTap: onComplete,
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: secondaryColor,
                          ),
                          child: const Center(
                            child: Icon(Icons.check, color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
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
