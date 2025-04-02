import 'package:flutter/material.dart';
import 'package:smart_health/app/data/models/wellness_metrics.dart';



class HealthSummaryCard extends StatelessWidget {
  final WellnessMetrics healthData;

  const HealthSummaryCard({super.key, required this.healthData});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: _buildHealthItem(
                        context,
                        Icons.water_drop,
                        'Water',
                        '${healthData.hydrationLevel} ml',
                        Theme.of(context).colorScheme.primary.withOpacity(0.2),
                      ),
                    ),
                    SizedBox(width: 8), // Add spacing between items
                    Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: _buildHealthItem(
                        context,
                        Icons.directions_walk,
                        'Steps',
                        '${healthData.stepCount}',
                        Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                      )),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: _buildHealthItem(
                        context,
                        Icons.self_improvement,
                        'Meditation',
                        '${healthData.mindfulnessMinutes} min',
                        Theme.of(context).colorScheme.tertiary.withOpacity(0.2),
                      ),
                    ),
                    SizedBox(width: 8), // Add spacing between items
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: _buildHealthItem(
                  context,
                  Icons.accessibility_new,
                  'Posture',
                  _getTimeSinceLastPostureCheck(),
                  Theme.of(context).colorScheme.error.withOpacity(0.2),
                ),
              ),
            ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHealthItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
    Color iconBackgroundColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Theme.of(context).colorScheme.onSurface),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getTimeSinceLastPostureCheck() {
    final now = DateTime.now();
    final difference = now.difference(healthData.postureCheckTimestamp);
    
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hr ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }
}

