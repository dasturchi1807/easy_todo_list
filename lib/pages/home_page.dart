import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/data/dataBase.dart';
import 'package:todo_app/util/dialogBox.dart';
import 'package:todo_app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _myBox = Hive.box("mybox");

  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {

    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  final controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateData();
  }

  saveNewTask() {
    setState(() {
      db.toDoList.add([controller.text, false]);
    });
    db.updateData();
  }

  void createNewTask() {
    showDialog(context: context, builder: (context) {
      return DialogBox(
        controller: controller,
        onSave: () {
          saveNewTask();
          controller.clear();
          Navigator.pop(context);
        },
        onCancel: () => Navigator.pop(context));
    });
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade200,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            db.toDoList.clear();
            setState(() {});
          },
              icon: const Icon(Icons.delete))
        ],
        backgroundColor: Colors.yellow,
        title: const Text("To Do"),
        elevation: 0,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Colors.yellow,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      body: db.toDoList.isNotEmpty ? ListView.builder(
        itemCount: db.toDoList.length,
      itemBuilder: (context, index) {
        return TodoTile(taskName: db.toDoList[index][0],
          taskCompleted: db.toDoList[index][1],
          onChanged: (value) => checkBoxChanged(value, index),
          deleteFunction: (context) => deleteTask(index));
      },
      ) : const Center(
        child: Text("To Do hali bo'sh", style: TextStyle(
          fontSize: 20
        ),),
      )
    );
  }
}