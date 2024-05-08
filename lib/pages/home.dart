import 'package:flutter/material.dart';
import 'package:todo_list/widgets/dialog_box.dart';
import 'package:todo_list/widgets/todo_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //text controller
  final _controller = TextEditingController();

  //list 
  List toDoList = [];

  //checkbox was tapped
  void checkBoxChanged(bool? value, int index){
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  //save new task
  void saveNewTask(){
    setState(() {
      toDoList.add([_controller.text,false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }
  //create new task
  void createNewTask(){
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

  //delete task
  void deleteTask(int index){
    setState(() {
      toDoList.removeAt(index);
    });
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
            searchBox(), 
            Expanded(
              child: ListView.builder(  
                itemCount: toDoList.length,
                itemBuilder: (context, index) {
                  return ToDoItem(
                    taskName: toDoList[index][0], 
                    taskCompleted: toDoList[index][1], 
                    onChanged: (value) => checkBoxChanged(value,index),
                    deleteFunction: (context) => deleteTask(index));
                },
              ),
            ),
          ],
        )
    );
  }

  Container searchBox() {
    return Container(
            margin: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12,style:BorderStyle.solid),
              borderRadius: BorderRadius.circular(15)
            ),
            child: const TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.blueGrey),
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
              ),
            ),
          );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text('ToDo List',style: TextStyle(fontWeight: FontWeight.bold,),),
      backgroundColor: const Color.fromARGB(220, 255, 255, 255),
      centerTitle: true,
      leading: GestureDetector(
        child: const Icon(Icons.menu,size: 25,),
        onTap: () {},
        ),
    );
  }
}


          // Container(
          //     margin: const EdgeInsets.only(top: 10,bottom: 5,),
          //     child: const Text('All ToDo\'s',style: TextStyle(
          //     fontWeight: FontWeight.w600,
          //     fontSize: 30,
          //     ),
          //   ),
          // ),



  