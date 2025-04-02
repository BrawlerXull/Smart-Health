class WellnessMetrics {
  final int hydrationLevel;
  final int stepCount;
  final int mindfulnessMinutes;
  final DateTime postureCheckTimestamp;
  final int sleepHours;
  final int caloriesBurned;
  final double heartRate;
  final double stressLevel;

  WellnessMetrics({
    required this.hydrationLevel,
    required this.stepCount,
    required this.mindfulnessMinutes,
    required this.postureCheckTimestamp,
    this.sleepHours = 0,
    this.caloriesBurned = 0,
    this.heartRate = 0.0,
    this.stressLevel = 0.0,
  });

  WellnessMetrics copyWith({
    int? hydrationLevel,
    int? stepCount,
    int? mindfulnessMinutes,
    DateTime? postureCheckTimestamp,
    int? sleepHours,
    int? caloriesBurned,
    double? heartRate,
    double? stressLevel,
  }) {
    return WellnessMetrics(
      hydrationLevel: hydrationLevel ?? this.hydrationLevel,
      stepCount: stepCount ?? this.stepCount,
      mindfulnessMinutes: mindfulnessMinutes ?? this.mindfulnessMinutes,
      postureCheckTimestamp: postureCheckTimestamp ?? this.postureCheckTimestamp,
      sleepHours: sleepHours ?? this.sleepHours,
      caloriesBurned: caloriesBurned ?? this.caloriesBurned,
      heartRate: heartRate ?? this.heartRate,
      stressLevel: stressLevel ?? this.stressLevel,
    );
  }
}
