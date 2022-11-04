import 'dart:collection';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tool_app/modal/Task.dart';

class TaskProvider extends ChangeNotifier {
  DatabaseReference ref = FirebaseDatabase.instance.ref("todo/");
  List<Task> _tasks = [];

  TaskProvider() {
    ref.onChildAdded.listen((event) {
      var decode = jsonEncode(event.snapshot.value);
      _add(Task.fromJson(json.decode(decode)));
    });

    ref.onChildRemoved.listen((event) {
      var decode = jsonEncode(event.snapshot.value);
      _remove(Task.fromJson(json.decode(decode)));
    });

    ref.onChildChanged.listen((event) {
      var decode = jsonEncode(event.snapshot.value);
      _update(Task.fromJson(json.decode(decode)));
    });
  }

  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);

  UnmodifiableListView<Task> itemsWithParameter(bool value) {
    return UnmodifiableListView(
        _tasks.where((Task item) => item.isCheck == value));
  }

  void addInBdd(Task item) async {
    var newChildRef = ref.push();
    item.id = newChildRef.key!;
    newChildRef.set(item.toJson());
  }
  void _add(Task item) {
    _tasks.add(item);
    notifyListeners();
  }

  void removeInBdd(String id) async{
    await ref.child(id).remove();
  }

  void _remove(Task task) {
    _tasks.removeWhere((element) => element.id == task.id );
    notifyListeners();
  }

  void updateInBdd(Task task) async{
    await ref.child(task.id).update(task.toJson());
  }
  
  void _update(Task task){
    int index = _tasks.indexWhere((element) => element.id == task.id);
    _tasks[index] = task;
    notifyListeners();
  }


}
