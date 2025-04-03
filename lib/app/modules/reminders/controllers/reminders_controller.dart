import 'package:get/get.dart';
import 'package:smart_health/app/data/models/wellness_alert.dart';
import 'package:flutter/material.dart';

class RemindersController extends GetxController {
  final reminders = <WellnessAlert>[
    WellnessAlert(
      alertId: "1",
      alertTitle: "Hydration Alert 💧",
      alertMessage: "Stay refreshed! Time for a water break.",
      category: AlertCategory.hydration,
      interval: AlertInterval.hourly,
      alertTime: const TimeOfDay(hour: 10, minute: 0),
      isEnabled: true,
    ),
    WellnessAlert(
      alertId: "2",
      alertTitle: "Stretch Break 🧘",
      alertMessage: "Take a moment to stretch and relax your muscles.",
      category: AlertCategory.movement,
      interval: AlertInterval.hourly,
      alertTime: const TimeOfDay(hour: 12, minute: 0),
      isEnabled: true,
    ),
    WellnessAlert(
      alertId: "3",
      alertTitle: "Mindfulness Reminder 🌿",
      alertMessage: "Pause for a deep breath and mindfulness exercise.",
      category: AlertCategory.mindfulness,
      interval: AlertInterval.daily,
      alertTime: const TimeOfDay(hour: 15, minute: 0),
      isEnabled: true,
    ),
    WellnessAlert(
      alertId: "4",
      alertTitle: "Evening Wind Down 🌙",
      alertMessage: "Unplug and relax before bedtime.",
      category: AlertCategory.mindfulness,
      interval: AlertInterval.daily,
      alertTime: const TimeOfDay(hour: 21, minute: 30),
      isEnabled: true,
    ),
  ].obs;

  final nextReminder = Rxn<WellnessAlert>();

  @override
  void onInit() {
    super.onInit();
    updateNextReminder();
  }

  void updateNextReminder() {
    final now = TimeOfDay.now();
    final upcomingReminders = reminders
        .where((alert) =>
            alert.isEnabled &&
            (alert.alertTime.hour > now.hour ||
                (alert.alertTime.hour == now.hour &&
                    alert.alertTime.minute > now.minute)))
        .toList();

    upcomingReminders.sort(
      (a, b) => (a.alertTime.hour * 60 + a.alertTime.minute)
          .compareTo(b.alertTime.hour * 60 + b.alertTime.minute),
    );

    nextReminder.value = upcomingReminders.isNotEmpty ? upcomingReminders.first : null;
  }

  void toggleReminderActive(String alertId) {
    final index = reminders.indexWhere((alert) => alert.alertId == alertId);
    if (index != -1) {
      reminders[index] = reminders[index].copyWith(isEnabled: !reminders[index].isEnabled);
      updateNextReminder();
    }
  }

  void deleteReminder(String alertId) {
    reminders.removeWhere((alert) => alert.alertId == alertId);
    updateNextReminder();
  }

  void addReminder(WellnessAlert newReminder) {
    reminders.add(newReminder);
    updateNextReminder();
  }

  void editReminder(String alertId, WellnessAlert updatedReminder) {
    final index = reminders.indexWhere((alert) => alert.alertId == alertId);
    if (index != -1) {
      reminders[index] = updatedReminder;
      updateNextReminder();
    }
  }
}
