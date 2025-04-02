class Challenge {
  final String challengeId;
  final String challengeTitle;
  final String challengeDescription;
  final int goalProgress;
  final int achievedProgress;
  final int rewardPoints;

  Challenge({
    required this.challengeId,
    required this.challengeTitle,
    required this.challengeDescription,
    required this.goalProgress,
    required this.achievedProgress,
    required this.rewardPoints,
  });

  bool get isCompleted => achievedProgress >= goalProgress;
  double get progressPercentage => achievedProgress / goalProgress;

  Challenge copyWith({
    String? challengeId,
    String? challengeTitle,
    String? challengeDescription,
    int? goalProgress,
    int? achievedProgress,
    int? rewardPoints,
  }) {
    return Challenge(
      challengeId: challengeId ?? this.challengeId,
      challengeTitle: challengeTitle ?? this.challengeTitle,
      challengeDescription: challengeDescription ?? this.challengeDescription,
      goalProgress: goalProgress ?? this.goalProgress,
      achievedProgress: achievedProgress ?? this.achievedProgress,
      rewardPoints: rewardPoints ?? this.rewardPoints,
    );
  }
}
