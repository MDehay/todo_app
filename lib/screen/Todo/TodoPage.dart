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
        if (items.isEmpty) {
          return Center(
              child: Text(
            (isCheck) ? "Vous n'avez aucune tâche terminé" : "Vous n'avez pas de tâche en cours",
            style: TextStyle(fontSize: 25, color: Colors.black),
                textAlign: TextAlign.center,
          ));
        } else {
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
                          updateTask(context, items[index]);
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
        }
      },
    );
  }

  void deleteTask(BuildContext context, Task item) {
    showDialog(
      context: context,
      builder: (context) {
        return SingleDialog(
          title: "Voulez vous supprimer la tache ${item.id.substring(0, 8)}",
          content: Text(item.text),
          textOKButton: "Conserver",
          textCancelButton: "Supprimer",
          callbackOK: () {},
          callbackCancel: () =>
              Provider.of<TaskProvider>(context, listen: false)
                  .removeInBdd(item.id),
        );
      },
    );
  }

  void updateTask(BuildContext context, Task item) {
    showDialog(
      context: context,
      builder: (context) {
        return SingleDialog(
          title: (item.isCheck)
              ? "Voulez vous annuler la tache ${item.id.substring(0, 8)}"
              : "Voulez vous validez la tache ${item.id.substring(0, 8)}",
          content: Text(item.text),
          textOKButton: "Valider",
          textCancelButton: "Annuler",
          callbackOK: () {
            item.isCheck = !item.isCheck;
            Provider.of<TaskProvider>(context, listen: false).updateInBdd(item);
          },
          callbackCancel: () {},
        );
      },
    );
  }
}
