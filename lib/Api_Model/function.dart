
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:practice/Api_Model/tasksmodel.dart';
import 'package:http/http.dart' as http ;


String url = "https://api.todoist.com/rest/v2";
//String token = "29647_66e56f9a8acefa7378415b40";
String taskToken = "4bc84fc6c9df7d6f6f892286ad086b24d592e0c1";

Future<TasksModel?> createTask( TasksModel newTask) async {
  final response = await http.post(
    Uri.parse('https://api.todoist.com/rest/v2/tasks'),
    headers: {'Authorization':'Bearer $taskToken' , 'Content-Type': 'application/json'},
    body: jsonEncode(newTask),
  );

  if (response.statusCode == 201) { // Check for successful creation (201 Created)
    return TasksModel.fromJson(jsonDecode(response.body));
  } else {
    print('Error creating task: ${response.statusCode}');
    return null;
  }
}


Future<bool> deleteTask(String taskId) async {
  final response = await http.delete(
    Uri.parse('$url/tasks/$taskId'),
    headers: {"Authorization": "Bearer $taskToken"},
  );

  if (response.statusCode == 200) { 
    return true;
  } else {
    print('Error deleting task: ${response.statusCode}');
    return false;
  }
}

Future<TasksModel?> updateTask(TasksModel updatedTask) async {
  final response = await http.put(
    Uri.parse('$url/tasks/${updatedTask.id}'),
    headers: {'Content-Type': 'application/json' , "Authorization": "Bearer $taskToken"},
    body: jsonEncode(updatedTask.toJson()),
  );

  if (response.statusCode == 200) { // Check for successful update (200 OK)
    return TasksModel.fromJson(jsonDecode(response.body));
  } else {
    print('Error updating task: ${response.statusCode}');
    return null;
  }
}

// Add this method to handle delete confirmation
  Future<bool> _confirmDelete(String taskId) async {
    var context;
    final confirmation = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),

          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    return
 confirmation ?? false; // Default to false if dialog is dismissed
  }



Future<List<TasksModel>> readAllTasks() async {
  final response = await http.get(Uri.parse('$url/tasks'),
  headers: {"Authorization": "Bearer $taskToken"});

  if (response.statusCode == 200) { // Check for successful retrieval (200 OK)
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((item) => TasksModel.fromJson(item)).toList();
  } else {
    print('Error reading tasks: ${response.statusCode}');
    return [];
  }
}