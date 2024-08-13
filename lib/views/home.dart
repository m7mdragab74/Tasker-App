import 'package:flutter/material.dart';

import '../database/db_helpers.dart';
import '../models/db_model.dart';
import '../widget/task_form.dart';
import '../widget/task_list.dart';
import '../widget/time_head.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    var dbHelper = DbHelper();
    List<Map<String, dynamic>> tasks = await dbHelper.getTasks();
    setState(() {
      _tasks = tasks.map((task) => Task.fromMap(task)).toList();
    });
  }

  void _refreshTasks() => _fetchTasks();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text(
          'Tasker',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      drawer: const Drawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => TaskForm(onTaskAdded: _refreshTasks),
          );
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: Column(
        children: [
          DateHeader(),
          Expanded(
            child: TaskList(tasks: _tasks),
          ),
        ],
      ),
    );
  }
}
