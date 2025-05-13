class WorkoutModel {
  String image;
  String title;
  String time;
  String? exercises;
  String? description;
  bool? isCompleted;

  WorkoutModel({
    required this.image,
    required this.title,
    required this.time,
    this.exercises,
    this.description,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'title': title,
      'time': time,
      'exercises': exercises,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  factory WorkoutModel.fromJson(Map<String, dynamic> json) {
    return WorkoutModel(
      image: json['image'] as String,
      title: json['title'] as String,
      time: json['time'] as String,
      exercises: json['exercises'] as String?,
      description: json['description'] as String?,
      isCompleted: json['isCompleted'] as bool?,
    );
  }
}