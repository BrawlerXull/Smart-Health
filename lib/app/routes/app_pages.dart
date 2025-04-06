import 'package:get/get.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/challenges/bindings/challenges_binding.dart';
import '../modules/challenges/views/challenges_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/fitbit/bindings/fitbit_binding.dart';
import '../modules/fitbit/bindings/fitbit_binding.dart';
import '../modules/fitbit/views/fitbit_view.dart';
import '../modules/fitbit/views/fitbit_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

import '../modules/leaderboard/bindings/leaderboard_binding.dart';
import '../modules/leaderboard/views/leaderboard_view.dart';
import '../modules/medi_buddy/bindings/medi_buddy_binding.dart';
import '../modules/medi_buddy/views/medi_buddy_view.dart';
import '../modules/medication/bindings/medication_binding.dart';
import '../modules/medication/views/medication_view.dart';
import '../modules/posture_tracker/bindings/posture_tracker_binding.dart';
import '../modules/posture_tracker/views/posture_tracker_view.dart';
import '../modules/reminders/bindings/reminders_binding.dart';
import '../modules/reminders/views/reminders_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.REMINDERS,
      page: () => const RemindersView(),
      binding: RemindersBinding(),
    ),
    GetPage(
      name: _Paths.CHALLENGES,
      page: () => const ChallengesView(),
      binding: ChallengesBinding(),
    ),
    GetPage(
      name: _Paths.MEDI_BUDDY,
      page: () => const MediBuddyView(),
      binding: MediBuddyBinding(),
    ),
    GetPage(
      name: _Paths.LEADERBOARD,
      page: () => const LeaderboardView(),
      binding: LeaderboardBinding(),
    ),
    GetPage(
      name: _Paths.POSTURE_TRACKER,
      page: () => const PostureTrackerView(),
      binding: PostureTrackerBinding(),
    ),
    GetPage(
      name: _Paths.FITBIT,
      page: () => const FitbitView(),
      binding: FitbitBinding(),
      children: [
        GetPage(
          name: _Paths.FITBIT,
          page: () => const FitbitView(),
          binding: FitbitBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.MEDICATION,
      page: () => const MedicationView(),
      binding: MedicationBinding(),
    ),
  ];
}
