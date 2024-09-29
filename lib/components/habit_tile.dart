import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
  final bool isCompleted;
  final String habitName;
  final void Function(bool?)? onChanged;
  final void Function(BuildContext)? editHabit;
  final void Function(BuildContext)? deleteHabit;
  const HabitTile({
    super.key,
    required this.isCompleted,
    required this.habitName,
    required this.onChanged,
    required this.editHabit,
    required this.deleteHabit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteHabit,
              backgroundColor: Colors.red.shade600,
              icon: Icons.delete_outlined,
              borderRadius: BorderRadius.circular(8),
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: editHabit,
              backgroundColor: Colors.blue.shade600,
              icon: Icons.settings_outlined,
              borderRadius: BorderRadius.circular(8),
              label: 'Edit',
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            if (onChanged != null) {
              onChanged!(!isCompleted);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: isCompleted
                  ? Colors.green.shade600
                  : Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(
                habitName,
                style: TextStyle(
                  color: isCompleted
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Checkbox(
                value: isCompleted,
                onChanged: onChanged,
                activeColor: Colors.greenAccent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
