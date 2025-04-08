import 'package:flutter/material.dart';
import 'package:smart_health/app/data/service/weather_service.dart';
import 'package:smart_health/app/data/utils/constants.dart';
import 'package:smart_health/app/widgets/custom_clipper.dart';

class WeatherCard extends StatelessWidget {
  final double recommendedDailyGoal;

  WeatherCard({
    Key? key,
    required this.recommendedDailyGoal,
  }) : super(key: key);

  final WeatherService _weatherService = WeatherService();
  final HydrationRecommendationService _recommendationService = HydrationRecommendationService();

  Future<void> _fetchWeatherData(BuildContext context) async {
    try {
      final weatherData = await _weatherService.getWeatherForMumbai();
      final temperature = _weatherService.getCurrentTemperature(weatherData);
      final recommendedIntake = _recommendationService.getRecommendedIntake(temperature);
      final advice = _recommendationService.getHydrationAdvice(temperature);

      // Show data in dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Weather Data Fetched'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Temperature: ${temperature.toStringAsFixed(1)}°C'),
                Text('Recommended Hydration: ${recommendedIntake.toInt()} ml'),
                Text('Hydration Advice: $advice'),
              ],
            ),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load weather data'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final secondaryColor = Theme.of(context).colorScheme.secondary;

    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
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
                    color: Colors.redAccent.withOpacity(0.1),
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
                        Icons.wb_sunny,
                        color: secondaryColor,
                        size: 26,
                      ),
                      Text(
                        '35.0°C', // Dummy data for temperature
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
                              'Mumbai Weather', // Placeholder for location or title
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Constants.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'It’s quite hot today! Stay hydrated.',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Constants.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Recommended Hydration Goal',
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
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Daily goal updated to ${recommendedDailyGoal.toInt()} ml'),
                              backgroundColor: Colors.greenAccent,
                            ),
                          );
                        },
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
}
