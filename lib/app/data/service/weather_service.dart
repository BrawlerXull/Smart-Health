import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String apiKey = 'd93e9a15a41a7e7eb6de2c0f15dab232';
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<Map<String, dynamic>> getWeatherForMumbai() async {
    final response = await http.get(
      Uri.parse('$baseUrl/weather?q=Mumbai,in&units=metric&appid=$apiKey'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  double getCurrentTemperature(Map<String, dynamic> weatherData) {
    return weatherData['main']['temp'];
  }
}

class HydrationRecommendationService {
  double getRecommendedIntake(double temperatureCelsius) {
    double baseRecommendation = 2000.0;

    if (temperatureCelsius > 35) {
      return baseRecommendation * 1.5;
    } else if (temperatureCelsius > 30) {
      return baseRecommendation * 1.3;
    } else if (temperatureCelsius > 25) {
      return baseRecommendation * 1.15;
    } else if (temperatureCelsius < 15) {
      return baseRecommendation * 0.9;
    }

    return baseRecommendation;
  }

  String getHydrationAdvice(double temperatureCelsius) {
    if (temperatureCelsius > 35) {
      return "It's extremely hot and humid in Mumbai today! Make sure to drink plenty of water and avoid going outside during peak heat.";
    } else if (temperatureCelsius > 30) {
      return "Hot and humid weather in Mumbai. Stay hydrated by drinking water regularly and avoid too much outdoor activity.";
    } else if (temperatureCelsius > 25) {
      return "The weather in Mumbai is warm today. Drink water frequently, especially if you’re spending time outdoors.";
    } else if (temperatureCelsius < 15) {
      return "It’s cooler in Mumbai today, but don’t forget to stay hydrated as the humidity can still make you feel warm.";
    } else {
      return "Pleasant weather in Mumbai today. Keep a steady intake of water to maintain energy and hydration throughout the day.";
    }
  }
}
