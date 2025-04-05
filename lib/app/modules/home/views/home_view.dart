import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:smart_health/app/modules/challenges/views/challenges_view.dart';
import 'package:smart_health/app/modules/dashboard/views/dashboard_view.dart';
import 'package:smart_health/app/modules/leaderboard/views/leaderboard_view.dart';
import 'package:smart_health/app/modules/medi_buddy/views/medi_buddy_view.dart';
import 'package:smart_health/app/modules/reminders/views/reminders_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

  static const List<Widget> _widgetOptions = <Widget>[
    DashboardView(),
    RemindersView(),
    ChallengesView(),
    MediBuddyView(),
    LeaderboardView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() => _widgetOptions[controller.selectedIndex.value]),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: Obx(
              () => GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical:7),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.black,
                tabs: const [
                  GButton(icon: LineIcons.book, text: 'Dashboard'),
                  GButton(icon: LineIcons.check, text: 'Check'),
                  GButton(icon: LineIcons.tasks, text: 'Challenges'),
                  GButton(icon: LineIcons.doctor, text: 'MediBuddy'),
                  GButton(icon: LineIcons.school, text: 'Leaderboard'),
                ],
                selectedIndex: controller.selectedIndex.value,
                onTabChange: controller.changeIndex,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
