import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:mini_habits/models/app_settings.dart';
import 'package:mini_habits/models/habit_model.dart';
import 'package:path_provider/path_provider.dart';

class HabitDatabase extends ChangeNotifier {
  static late Isar isar;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [HabitSchema, AppSettingsSchema],
      directory: dir.path,
    );
  }

  Future<void> saveFirstRun() async {
    final existingAppSettings = await isar.appSettings.where().findFirst();
    if (existingAppSettings == null) {
      final appSettings = AppSettings()..firstRun = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(appSettings));
    }
  }

  Future<DateTime?> getFirstRun() async {
    final appSettings = await isar.appSettings.where().findFirst();
    return appSettings?.firstRun;
  }

  final List<Habit> currentHabits = [];

  Future<void> addHabit(String habitName) async {
    final habit = Habit()..name = habitName;
    await isar.writeTxn(() => isar.habits.put(habit));
    readHabits();
  }

  Future<void> readHabits() async {
    List<Habit> fetchedHabits = await isar.habits.where().findAll();
    currentHabits.clear();
    currentHabits.addAll(fetchedHabits);
    notifyListeners();
  }

  Future<void> updateHabitStatus(int id, bool isCompleted) async {
    final habit = await isar.habits.get(id);
    if (habit != null) {
      await isar.writeTxn(() async {
        if (isCompleted && !habit.completedDays.contains(DateTime.now())) {
          final today = DateTime.now();
          habit.completedDays.add(
            DateTime(
              today.year,
              today.month,
              today.day,
            ),
          );
        } else {
          habit.completedDays.removeWhere((date) =>
              date.year == DateTime.now().year &&
              date.month == DateTime.now().month &&
              date.day == DateTime.now().day);
        }
        await isar.habits.put(habit);
      });
    }
    readHabits();
  }

  Future<void> updateHabitName(int id, String name) async {
    final habit = await isar.habits.get(id);
    if (habit != null) {
      await isar.writeTxn(() async {
        habit.name = name;
        await isar.habits.put(habit);
      });
    }
    readHabits();
  }

  Future<void> deleteHabit(int id) async {
    await isar.writeTxn(() async {
      await isar.habits.delete(id);
    });
    readHabits();
  }
}
