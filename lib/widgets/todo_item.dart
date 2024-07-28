import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoItem extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final Function(bool?) onChanged;
  final Function(BuildContext)? deleteFunction;
  final Function()? edit;
  const ToDoItem(
      {super.key,
      required this.taskName,
      required this.taskCompleted,
      required this.onChanged,
      required this.deleteFunction,
      required this.edit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 6, top: 15),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(12),
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          height: 55,
          width: 380,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(value: taskCompleted, onChanged: onChanged),
                  Text(
                    taskName,
                    style: TextStyle(
                      fontSize: 16,
                      decoration: taskCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: edit,
                icon: const Icon(
                  Icons.edit,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


// Padding(
//       padding: const EdgeInsets.only(left: 10,right: 10,top: 12),
//       child: Container(
//         child: ListTile(
//           onTap: () {},
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//           tileColor: Colors.white,
//           leading: Checkbox(value: false, onChanged: (value) {},),
//           title: const Text('Hello',style: TextStyle(fontSize: 20),),
//         ),
//       ),
//     );