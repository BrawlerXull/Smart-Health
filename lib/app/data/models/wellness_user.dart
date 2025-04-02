class WellnessUser {
  final String userId;
  final String fullName;
  final String emailAddress;
  final String? profileImageUrl;
  final int age;
  final double bodyWeight;
  final double bodyHeight;
  final String biologicalSex;
  final int activityScale;
  final String? fitnessGoal;
  final String? preferredWorkoutType;
  final double? bodyFatPercentage;

  WellnessUser({
    required this.userId,
    required this.fullName,
    required this.emailAddress,
    this.profileImageUrl,
    required this.age,
    required this.bodyWeight,
    required this.bodyHeight,
    required this.biologicalSex,
    required this.activityScale,
    this.fitnessGoal,
    this.preferredWorkoutType,
    this.bodyFatPercentage,
  });

  WellnessUser copyWith({
    String? userId,
    String? fullName,
    String? emailAddress,
    String? profileImageUrl,
    int? age,
    double? bodyWeight,
    double? bodyHeight,
    String? biologicalSex,
    int? activityScale,
    String? fitnessGoal,
    String? preferredWorkoutType,
    double? bodyFatPercentage,
  }) {
    return WellnessUser(
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      emailAddress: emailAddress ?? this.emailAddress,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      age: age ?? this.age,
      bodyWeight: bodyWeight ?? this.bodyWeight,
      bodyHeight: bodyHeight ?? this.bodyHeight,
      biologicalSex: biologicalSex ?? this.biologicalSex,
      activityScale: activityScale ?? this.activityScale,
      fitnessGoal: fitnessGoal ?? this.fitnessGoal,
      preferredWorkoutType: preferredWorkoutType ?? this.preferredWorkoutType,
      bodyFatPercentage: bodyFatPercentage ?? this.bodyFatPercentage,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'fullName': fullName,
      'emailAddress': emailAddress,
      'profileImageUrl': profileImageUrl,
      'age': age,
      'bodyWeight': bodyWeight,
      'bodyHeight': bodyHeight,
      'biologicalSex': biologicalSex,
      'activityScale': activityScale,
      'fitnessGoal': fitnessGoal,
      'preferredWorkoutType': preferredWorkoutType,
      'bodyFatPercentage': bodyFatPercentage,
    };
  }

  factory WellnessUser.fromJson(Map<String, dynamic> json) {
    return WellnessUser(
      userId: json['userId'],
      fullName: json['fullName'],
      emailAddress: json['emailAddress'],
      profileImageUrl: json['profileImageUrl'],
      age: json['age'],
      bodyWeight: json['bodyWeight'],
      bodyHeight: json['bodyHeight'],
      biologicalSex: json['biologicalSex'],
      activityScale: json['activityScale'],
      fitnessGoal: json['fitnessGoal'],
      preferredWorkoutType: json['preferredWorkoutType'],
      bodyFatPercentage: json['bodyFatPercentage'],
    );
  }

  double get bmi {
    final heightInMeters = bodyHeight / 100;
    return bodyWeight / (heightInMeters * heightInMeters);
  }

  String get bmiCategory {
    final bmiValue = bmi;
    if (bmiValue < 18.5) {
      return 'Underweight';
    } else if (bmiValue < 25) {
      return 'Normal';
    } else if (bmiValue < 30) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }

  int get dailyCalorieRequirement {
    double bmr;
    if (biologicalSex.toLowerCase() == 'male') {
      bmr = 10 * bodyWeight + 6.25 * bodyHeight - 5 * age + 5;
    } else {
      bmr = 10 * bodyWeight + 6.25 * bodyHeight - 5 * age - 161;
    }

    final activityMultipliers = [1.2, 1.375, 1.55, 1.725, 1.9];
    final index = activityScale - 1;
    return (bmr * activityMultipliers[index]).round();
  }
}
