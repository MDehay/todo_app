import 'package:uuid/uuid.dart';

class Task{

  final Uuid id;
  String text;
  bool isCheck;

  Task({this.id = const Uuid(),required this.text, this.isCheck = false});
}