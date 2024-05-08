import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoItem extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?) onChanged;
  Function(BuildContext)? deleteFunction;
  ToDoItem({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 8),
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
          margin: const EdgeInsets.only(left: 20,right: 20),
          height: 50,
          width: 350,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12),),
          child: Row(
            children: [
        
            Checkbox(value: taskCompleted, onChanged: onChanged),
        
              Text(taskName,style: TextStyle(fontSize: 16,decoration: taskCompleted? TextDecoration.lineThrough: TextDecoration.none,),),
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