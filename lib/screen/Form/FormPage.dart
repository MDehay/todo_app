import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tool_app/modal/Task.dart';
import 'package:tool_app/provider/TaskProvider.dart';

class FormPage extends StatelessWidget {
  FormPage({Key? key}) : super(key: key);

  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: TextFormField(
        controller: _controller,
        validator: (text) => validator(text),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          label: Text("Votre tâche"),
        ),
      ),
    );
  }

  String? validator(String? text) {
    if (text!.isEmpty) {
      return "Text not be empty";
    } else {
      return null;
    }
  }

  void validationForm(BuildContext context) {
    if (_key.currentState!.validate()) {
      Provider.of<TaskProvider>(context,listen: false).addInBdd(Task(text: _controller.text));
    }
  }
}
