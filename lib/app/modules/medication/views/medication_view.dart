import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/medication_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smart_health/app/data/utils/constants.dart';
import 'package:smart_health/app/widgets/card_items.dart';
import 'package:smart_health/app/widgets/card_main.dart';
import 'package:smart_health/app/widgets/card_section.dart';
import 'package:smart_health/app/widgets/custom_clipper.dart';

class MedicationView extends GetView<MedicationController> {
  const MedicationView({super.key});
  @override
  Widget build(BuildContext context) {
  double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: MyCustomClipper(clipType: ClipType.bottom),
            child: Container(
              color: Theme.of(context).colorScheme.primary,
              height: Constants.headerHeight + statusBarHeight,
            ),
          ),
          Positioned(
              right: -45,
              top: -30,
              child: ClipOval(
                  child: Container(
                    color: Colors.black.withOpacity(0.05),
                    height: 220,
                    width: 220,
                  ),
              ),
          ),

          // BODY
          Padding(
            padding: EdgeInsets.all(Constants.paddingSide),
            child: ListView(
              children: <Widget>[
                // Header - Greetings and Avatar
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text("Good Morning,\nChinmay",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                              color: Colors.white
                          ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 26.0,
                      backgroundImage: AssetImage('assets/icons/profile_picture.png')
                    )
                  ],
                ),

                SizedBox(height: 50),

                // Main Cards - Heartbeat and Blood Pressure
                Container(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        CardMain(
                            image: AssetImage('assets/icons/heartbeat.png'),
                            title: "Hearbeat",
                            value: "66",
                            unit: "bpm",
                            color: Constants.lightGreen,
                        ),
                        CardMain(
                            image: AssetImage('assets/icons/blooddrop.png'),
                            title: "Blood Pressure",
                            value: "66/123",
                            unit: "mmHg",
                            color: Constants.lightYellow
                        )
                      ],
                    ),
                ),

                // Section Cards - Daily Medication
                SizedBox(height: 50),

                Text("YOUR DAILY MEDICATIONS",
                    style: TextStyle(
                        color: Constants.textPrimary,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                    ),
                ),

                SizedBox(height: 20),

                Container(
                    height: 130,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        CardSection(
                          image: AssetImage('assets/icons/capsule.png'),
                          title: "Metforminv",
                          value: "2",
                          unit: "pills",
                          time: "6-7AM",
                          isDone: false,
                        ),
                        CardSection(
                          image: AssetImage('assets/icons/syringe.png'),
                          title: "Trulicity",
                          value: "1",
                          unit: "shot",
                          time: "8-9AM",
                          isDone: true,
                        )
                      ],
                    )),

                SizedBox(height: 50),

                // Scheduled Activities
                Text("SCHEDULED ACTIVITIES",
                    style: TextStyle(
                        color: Constants.textPrimary,
                        fontSize: 13,
                        fontWeight: FontWeight.bold
                    ),
                ),

                SizedBox(height: 20),

                Container(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: <Widget>[
                        CardItems(
                          image: Image.asset(
                            'assets/icons/Walking.png',
                          ),
                          title: "Walking",
                          value: "750",
                          unit: "steps",
                          color: Constants.lightYellow,
                          progress: 30,
                        ),
                        CardItems(
                          image: Image.asset(
                            'assets/icons/Swimming.png',
                          ),
                          title: "Swimming",
                          value: "40",
                          unit: "min",
                          color: Constants.lightBlue,
                          progress: 30,
                        ),
                      ],
                    ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
