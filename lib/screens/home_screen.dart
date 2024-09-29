import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_habits/components/drawer.dart';
import 'package:mini_habits/components/habit_tile.dart';
import 'package:mini_habits/components/heat_map.dart';
import 'package:mini_habits/database/habit_database.dart';
import 'package:mini_habits/models/habit_model.dart';
import 'package:mini_habits/utils/habit_util.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<HabitDatabase>(context, listen: false).readHabits();
  }

  final TextEditingController _controller = TextEditingController();

  void createNewHabit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Habit name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
          ),
        ),
        actions: [
          MaterialButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
              _controller.clear();
            },
          ),
          MaterialButton(
            child: const Text('Add'),
            onPressed: () {
              String newHabitName = _controller.text;

              if (newHabitName.isEmpty) {
                Navigator.pop(context);
                return;
              }
              context.read<HabitDatabase>().addHabit(newHabitName);
              Navigator.pop(context);
              _controller.clear();
            },
          ),
        ],
      ),
    );
  }

  void checkHabitStatus(bool? val, Habit habit) {
    if (val != null) {
      context.read<HabitDatabase>().updateHabitStatus(habit.id, val);
    }
  }

  void deleteHabit(Habit habit) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete habit'),
        content: const Text('Are you sure you want to delete this habit ?'),
        actions: [
          MaterialButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          MaterialButton(
            child: const Text('Delete'),
            onPressed: () {
              context.read<HabitDatabase>().deleteHabit(habit.id);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void editHabit(Habit habit) {
    _controller.text = habit.name;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit habit'),
        content: TextField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Habit name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
          ),
        ),
        actions: [
          MaterialButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
              _controller.clear();
            },
          ),
          MaterialButton(
            child: const Text('Save'),
            onPressed: () {
              String newHabitName = _controller.text;
              if (newHabitName.isEmpty) {
                Navigator.pop(context);
                return;
              }
              context
                  .read<HabitDatabase>()
                  .updateHabitName(habit.id, newHabitName);
              Navigator.pop(context);
              _controller.clear();
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Mini Habits Tracker',
          style: TextStyle(
            fontFamily: GoogleFonts.dmSerifDisplay().fontFamily,
            letterSpacing: 1.5,
            fontSize: 20,
          ),
        ),
      ),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewHabit,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      body: ListView(
        children: [_buildHeatMap(), _buildHabitList()],
      ),
    );
  }

  Widget _buildHeatMap() {
    final habitDB = context.watch<HabitDatabase>();
    List<Habit> currentHabits = habitDB.currentHabits;
    return FutureBuilder<DateTime?>(
        future: habitDB.getFirstRun(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HeatMap(
                initDate: snapshot.data!,
                datasets: getHeatMapDataset(currentHabits));
          } else {
            return Container();
          }
        });
  }

  Widget _buildHabitList() {
    final habitDB = context.watch<HabitDatabase>();
    List<Habit> currentHabits = habitDB.currentHabits;

    return ListView.builder(
      itemCount: currentHabits.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final habit = currentHabits[index];
        bool isCompletedToday = isHabitCompletedToday(habit.completedDays);
        return HabitTile(
          habitName: habit.name,
          isCompleted: isCompletedToday,
          onChanged: (val) => checkHabitStatus(val, habit),
          editHabit: (context) => editHabit(habit),
          deleteHabit: (context) => deleteHabit(habit),
        );
      },
    );
  }
}
