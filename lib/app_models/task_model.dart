class Task {
  final String id;
  final String description;
  final String taskType;
  final String startTime;
  final String taskDuration;
  final String date;

  Task({
    required this.id,
    required this.description,
    required this.taskType,
    required this.date,
    required this.startTime,
    required this.taskDuration,
  });

  factory Task.fromJson(Map<String, dynamic> taskData) {
    // print(taskData);
    return Task(
      id: taskData['_id'],
      description: taskData['description'],
      taskType: taskData['type'],
      date: taskData['date'],
      startTime: taskData['startTime'],
      taskDuration: taskData['duration'],
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
