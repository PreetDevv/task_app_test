import 'package:flutter/material.dart';
import '../models/TaskModel.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;
  final ValueChanged<bool?> onChanged;

  const TaskItem({super.key, required this.task, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: task.isDone ? Colors.green.shade50 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: CheckboxListTile(
          value: task.isDone,
          onChanged: onChanged,
          title: Text(
            task.title,
            style: TextStyle(
              fontSize: 16,
              decoration: task.isDone ? TextDecoration.lineThrough : null,
              color: task.isDone ? Colors.grey : Colors.black,
            ),
          ),
        ));
  }
}
