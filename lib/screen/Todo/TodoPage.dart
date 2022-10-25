import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tool_app/modal/Task.dart';
import 'package:tool_app/provider/TaskProvider.dart';
import 'package:tool_app/screen/Dialog/SingleDialog.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({
    Key? key,
    required this.isCheck,
  }) : super(key: key);
  final bool isCheck;

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, provider, child) {
        List<Task> items = provider.itemsWithParameter(isCheck);
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(8),
              child: Card(
                color: (isCheck) ? Colors.grey[500] : Colors.blue[200],
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  leading: Checkbox(
                      value: (isCheck) ? true : false,
                      onChanged: (value) {
                        provider.changeValue(items[index].id);
                      }),
                  title: Text(items[index].text),
                  trailing: IconButton(
                    onPressed: () => deleteTask(context, items[index]),
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void deleteTask(BuildContext context, Task item) {
    showDialog(
      context: context,
      builder: (context) {
        return SingleDialog(
          title:
              "Voulez vous supprimer la tache ${item.id.v1().substring(0, 8)}",
          content: Text(item.text),
          textOKButton: "Conserver",
          textCancelButton: "Supprimer",
          callbackOK: () {},
          callbackCancel: () =>
              Provider.of<TaskProvider>(context, listen: false).remove(item),
        );
      },
    );
  }

  void updateTask(BuildContext context, Task item) {
    showDialog(
      context: context,
      builder: (context) {
        return SingleDialog(
          title:
          "Confirmer votre choix pour la tache ${item.id.v1().substring(0, 8)}",
          content: Text(item.text),
          textOKButton: "Valider",
          textCancelButton: "Annuler",
          callbackOK: () => Provider.of<TaskProvider>(context, listen: false).changeValue(item.id),
          callbackCancel: () {},
        );
      },
    );
  }
}
