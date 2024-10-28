import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  TodoTile({super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
            icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: taskCompleted ? Colors.grey.shade400 : Colors.yellow,
              borderRadius: BorderRadius.circular(12)
          ),
          child: Row(
              children: [
                Checkbox(value: taskCompleted, onChanged: onChanged, activeColor: Colors.orange),
                Expanded(
                  child: Text(taskName, style: TextStyle(
                    fontSize: 18,
                    decoration: taskCompleted ? TextDecoration.lineThrough : TextDecoration.none
                  ),),
                ),
              ],
            ),
          )
        ),
    );
  }
}
