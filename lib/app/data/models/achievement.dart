class Achievement {
  final String id;
  final String title;
  final String description;
  final int points;
  final bool isAchieved; 

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.points,
    required this.isAchieved,
  });

  Achievement copyWith({
    String? id,
    String? title,
    String? description,
    int? points,
    bool? isAchieved, 
  }) {
    return Achievement(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      points: points ?? this.points,
      isAchieved: isAchieved ?? this.isAchieved, 
    );
  }
}
