// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_app/models/screen/task_editor.dart';
import 'package:habit_app/models/task_model.dart';

class MyListTile extends StatefulWidget {
  MyListTile(this.task, this.index, {Key? key}) : super(key: key);
  Task task;
  int index;
  @override
  createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  bool _isCheck = false;
  bool _fav = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 12),
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Kullanıcı"),
                trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        _fav == false ? _fav = true : _fav = false;
                      });
                    },
                    icon: _fav
                        ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: Get.width * 0.1,
                          )
                        : Icon(
                            Icons.favorite_outline_rounded,
                            color: Colors.red,
                            size: Get.width * 0.1,
                          ))),
            const Divider(
              thickness: 1,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.task.title!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TaskEditor(
                                  task: widget.task,
                                )));
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.green,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    widget.task.delete();
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isCheck == false ? _isCheck = true : _isCheck = false;
                    });
                  },
                  icon: _isCheck
                      ? const Icon(Icons.check_box)
                      : const Icon(Icons.check_box_outline_blank),
                )
              ],
            ),
            const Divider(
              color: Colors.black87,
              height: 20.0,
              thickness: 1.0,
            ),
            Text(
              widget.task.note!,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ));
  }
}
