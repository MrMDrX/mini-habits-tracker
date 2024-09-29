import 'package:mini_habits/models/habit_model.dart';

bool isHabitCompletedToday(List<DateTime> completionDays) {
  return completionDays.any((day) =>
      day.year == DateTime.now().year &&
      day.month == DateTime.now().month &&
      day.day == DateTime.now().day);
}

Map<DateTime, int> getHeatMapDataset(List<Habit> habits) {
  Map<DateTime, int> dataset = {};
  for (var habit in habits) {
    for (var day in habit.completedDays) {
      final normalizedDate = DateTime(day.year, day.month, day.day);
      if (dataset.containsKey(normalizedDate)) {
        dataset[normalizedDate] = dataset[normalizedDate]! + 1;
      } else {
        dataset[normalizedDate] = 1;
      }
    }
  }
  return dataset;
}
