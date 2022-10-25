import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:tool_app/modal/Task.dart';
import 'package:uuid/uuid.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];

  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);

  UnmodifiableListView<Task> itemsWithParameter(bool value) {
    return UnmodifiableListView(_tasks.where((Task item) => item.isCheck == value));
  }

  void add(Task item) {
    _tasks.add(item);
    notifyListeners();
  }

  void remove(Task item) {
    _tasks.remove(item);
    notifyListeners();
  }

  void changeValue(Uuid id){
    int index = _tasks.indexWhere((element) => element.id == id);
    _tasks[index].isCheck = !_tasks[index].isCheck;
    notifyListeners();
  }
}
