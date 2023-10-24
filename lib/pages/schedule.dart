class Schedule {
  final String id;
  final String name;
  final List<Task> tasks;

  Schedule({required this.id, required this.name, required this.tasks});
}

class Task {
  final String id;
  final String name;
  final String location;
  final int day;
  final int minute;
  final int hour;
  final int minuteDuration;
  final int daysDuration;

  Task({
    required this.id,
    required this.name,
    required this.location,
    required this.day,
    required this.minute,
    required this.hour,
    required this.minuteDuration,
    required this.daysDuration,
  });
}
