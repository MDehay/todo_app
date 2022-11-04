import 'package:uuid/uuid.dart';

class Task{

  String id;
  String text;
  bool isCheck;

  Task({this.id = "",required this.text, this.isCheck = false});

  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        text = json['text'],
        isCheck = json['isCheck'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'isCheck': isCheck,
  };
}