bool isHabitCompletedToday(List<DateTime> completionDays) {
  return completionDays.any((day) =>
      day.year == DateTime.now().year &&
      day.month == DateTime.now().month &&
      day.day == DateTime.now().day);
}
