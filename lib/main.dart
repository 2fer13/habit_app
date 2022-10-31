import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:habit_app/models/screen/task_editor.dart';
import 'package:habit_app/models/task_model.dart';
import 'package:habit_app/widgets/my_list_tile.dart';
import 'package:hive_flutter/adapters.dart';

late Box box;
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Task>(TaskAdapter());
  box = await Hive.openBox<Task>("tasks");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: const Text(
            "Yapılacaklar Listesi",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: ValueListenableBuilder<Box<Task>>(
          valueListenable: Hive.box<Task>("tasks").listenable(),
          builder: (context, box, _) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Todays Task",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    formatDate(DateTime.now(), [d, "/", M, "/", yyyy]),
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 17,
                    ),
                  ),
                  const Divider(
                    height: 40,
                    thickness: 1,
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: box.values.length,
                          itemBuilder: (context, index) {
                            Task currenTask = box.getAt(index)!;
                            return MyListTile(currenTask, index);
                          }))
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TaskEditor()));
            },
            child: const Icon(Icons.add)));
  }
}
