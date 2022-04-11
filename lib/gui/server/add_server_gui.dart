import 'package:flutter/material.dart';
import 'package:plugpack_flutter/functions/server.dart';

class ServerGUI extends StatelessWidget {
  ServerGUI({Key? key}) : super(key: key);
  final nameController = TextEditingController();

  void save(BuildContext context) {
    Server.addServer(nameController.text);
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add server"),
        actions: [
          IconButton(
              onPressed: () {
                save(context);
              },
              icon: const Icon(Icons.save_rounded)),
        ],
      ),
      body: Form(
        child: ListView(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name",
                prefixIcon: const Icon(Icons.drive_file_rename_outline_rounded),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            )
          ],
          padding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}
