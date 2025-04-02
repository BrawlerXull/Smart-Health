import 'package:flutter/material.dart';

enum AlertCategory {
  hydration,
  postureCorrection,
  movement,
  mindfulness,
  custom,
}

enum AlertInterval {
  hourly,
  daily,
  weekly,
  custom,
}

class WellnessAlert {
  final String alertId;
  final String alertTitle;
  final String alertMessage;
  final AlertCategory category;
  final AlertInterval interval;
  final TimeOfDay alertTime;
  final bool isEnabled;

  WellnessAlert({
    required this.alertId,
    required this.alertTitle,
    required this.alertMessage,
    required this.category,
    required this.interval,
    required this.alertTime,
    required this.isEnabled,
  });

  WellnessAlert copyWith({
    String? alertId,
    String? alertTitle,
    String? alertMessage,
    AlertCategory? category,
    AlertInterval? interval,
    TimeOfDay? alertTime,
    bool? isEnabled,
  }) {
    return WellnessAlert(
      alertId: alertId ?? this.alertId,
      alertTitle: alertTitle ?? this.alertTitle,
      alertMessage: alertMessage ?? this.alertMessage,
      category: category ?? this.category,
      interval: interval ?? this.interval,
      alertTime: alertTime ?? this.alertTime,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'alertId': alertId,
      'alertTitle': alertTitle,
      'alertMessage': alertMessage,
      'category': category.index,
      'interval': interval.index,
      'alertHour': alertTime.hour,
      'alertMinute': alertTime.minute,
      'isEnabled': isEnabled,
    };
  }

  factory WellnessAlert.fromJson(Map<String, dynamic> json) {
    return WellnessAlert(
      alertId: json['alertId'],
      alertTitle: json['alertTitle'],
      alertMessage: json['alertMessage'],
      category: AlertCategory.values[json['category']],
      interval: AlertInterval.values[json['interval']],
      alertTime: TimeOfDay(hour: json['alertHour'], minute: json['alertMinute']),
      isEnabled: json['isEnabled'],
    );
  }
}
