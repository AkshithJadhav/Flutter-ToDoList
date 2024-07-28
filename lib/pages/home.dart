import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/data/database.dart';
import 'package:todo_list/widgets/dialog_box.dart';
import 'package:todo_list/widgets/edit_name.dart';
import 'package:todo_list/widgets/todo_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // reference the hive box
  final _myBox = Hive.box('mybox');

  @override
  void initState() {
    // if this is the first time ever opening the app, then create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }

    super.initState();
  }

  // text controller
  final _controller = TextEditingController();
  final TextEditingController _editController = TextEditingController();
  ToDoDataBase db = ToDoDataBase();

  // checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  // save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // create new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  // edit name of existing task
  void editButton(int index) {
    _editController.text = db.toDoList[index][0];
    showDialog(
      context: context,
      builder: (context) {
        return EditName(
          controller: _editController,
          onSave: () => editName(index),
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // edit name
  void editName(int index) {
    setState(() {
      db.toDoList[index][0] = _editController.text;
      _editController.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  //delete all tasks
  void deleteAll() {
    setState(() {
      db.toDoList.removeRange(0, db.toDoList.length);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(245, 255, 255, 255),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: const Icon(Icons.add),
        ),
        appBar: appBar(),
        body: Column(
          children: [
            // searchBox(),
            Expanded(
              child: ListView.builder(
                itemCount: db.toDoList.length,
                itemBuilder: (context, index) {
                  return ToDoItem(
                      edit: () => editButton(index),
                      taskName: db.toDoList[index][0],
                      taskCompleted: db.toDoList[index][1],
                      onChanged: (value) => checkBoxChanged(value, index),
                      deleteFunction: (context) => deleteTask(index));
                },
              ),
            ),
          ],
        ));
  }

  // Container searchBox() {
  //   return Container(
  //     margin: const EdgeInsets.all(25),
  //     decoration: BoxDecoration(
  //         border: Border.all(color: Colors.black12, style: BorderStyle.solid),
  //         borderRadius: BorderRadius.circular(15)),
  //     child: const TextField(
  //       decoration: InputDecoration(
  //         contentPadding: EdgeInsets.all(10),
  //         hintText: 'Search',
  //         hintStyle: TextStyle(color: Colors.blueGrey),
  //         prefixIcon: Icon(Icons.search),
  //         border: InputBorder.none,
  //       ),
  //     ),
  //   );
  // }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        'ToDo List',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color.fromARGB(220, 255, 255, 255),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: deleteAll,
          icon: const Icon(Icons.delete),
        ),
        const Padding(padding: EdgeInsets.only(right: 15))
      ],
    );
  }
}
