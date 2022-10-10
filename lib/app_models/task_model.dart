class Task {
  final String description;
  final String taskType;
  final String startTime;
  final String taskDuration;
  final String date;

  Task({
    required this.description,
    required this.taskType,
    required this.date,
    required this.startTime,
    required this.taskDuration,
  });

  factory Task.fromJson(Map<String, dynamic> taskData) {
    return Task(
      description: taskData['description'],
      taskType: taskData['taskType'],
      date: taskData['date'],
      startTime: taskData['startTime'],
      taskDuration: taskData['taskDuration'],
    );
  }

  Map<String, dynamic> toJson(Task task) {
    return {
      'description': task.description,
      'taskType': task.taskType,
      'date': task.date,
      'startTime': task.startTime,
      'taskDuration': task.taskDuration,
    };
  }
}
