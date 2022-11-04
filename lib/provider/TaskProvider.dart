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
      add(Task.fromJson(json.decode(decode)));
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

  void add(Task item) {
    _tasks.add(item);
    notifyListeners();
  }
  void getItem() async {
    String id = "-NG11mwpU7Ie7m2Z476O";
    final snapshot = await ref.child('$id').get();
    print(snapshot.value);
  }

  void remove(Task item) {
    _tasks.remove(item);
    notifyListeners();
  }

  void changeValue(String id) {
    int index = _tasks.indexWhere((element) => element.id == id);
    _tasks[index].isCheck = !_tasks[index].isCheck;
    notifyListeners();
  }
}

/*

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
 */
