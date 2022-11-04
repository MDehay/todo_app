import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tool_app/provider/TaskProvider.dart';
import 'package:tool_app/screen/Dialog/SingleDialog.dart';
import 'package:tool_app/screen/Form/FormPage.dart';
import 'package:tool_app/screen/Todo/TodoPage.dart';

import 'firebase_options.dart';
import 'modal/Task.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.blue[100],
        primarySwatch: Colors.blue,
      ),
      home: const DefaultTabController(length: 2, child: ControlleurPage()),
    );
  }
}

class ControlleurPage extends StatefulWidget {
  const ControlleurPage({Key? key}) : super(key: key);

  @override
  State<ControlleurPage> createState() => _ControlleurPageState();
}

class _ControlleurPageState extends State<ControlleurPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: const TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.check_box_outline_blank),
            ),
            Tab(
              icon: Icon(Icons.check_box),
            ),
          ],
        ),
      ),
      body: const TabBarView(
        children: [
          TodoPage(
            isCheck: false,
          ),
          TodoPage(
            isCheck: true,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Provider.of<TaskProvider>(context,listen: false).add(new Task(text: 'Ma Tache')),
        //onPressed: () => Provider.of<TaskProvider>(context,listen: false).getItem(),
        child: const Icon(Icons.add),
      ),
    );
  }

  void createTask() {
    FormPage app = FormPage();
    showDialog(
      context: context,
      builder: (context) {
        return SingleDialog(
          title: "Crée une nouvelle tache",
          content: app,
          textOKButton: "Crée une tache",
          textCancelButton: "Annuler",
          callbackOK: () => app.validationForm(context),
          callbackCancel: () {},
        );
      },
    );
  }

}
