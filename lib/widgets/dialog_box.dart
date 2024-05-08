import 'package:flutter/material.dart';
import 'package:todo_list/widgets/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
    });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SizedBox(
        height: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //user input
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.add),
                hintText: 'Add New Task',
                fillColor: Colors.white,
                filled: true,
                ),
            ),
            //buttons -> save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              //save button
              MyButton(text: "Save", onPressed: onSave),
              const SizedBox(width: 20,),
              //cancle button
              MyButton(text: 'Cancel', onPressed: onCancel),
            ],)

          ],
        ),
      ),
    );
  }
}