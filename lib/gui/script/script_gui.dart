import 'package:flutter/material.dart';
import 'package:plugpack_flutter/functions/generate_script.dart';
import 'package:plugpack_flutter/functions/import_script.dart';
import 'package:plugpack_flutter/main.dart';

class ScriptGUI extends StatefulWidget {
  const ScriptGUI({Key? key}) : super(key: key);

  @override
  _ScriptGUIState createState() => _ScriptGUIState();
}

class _ScriptGUIState extends State<ScriptGUI> {
  final scriptController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: const Text("Plugpack - Script"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () => {
                    ImportScript.importScript(scriptController.text),
                    contentStateKey.currentState!.updateIndex(0),
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.file_upload_rounded,
                        ),
                        Text(
                          "Import script",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () => {
                    scriptController.text = GenerateScript.generateScript(),
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.file_download_rounded,
                        ),
                        Text(
                          "Generate script",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                  style: BorderStyle.solid,
                ),
              ),
              child: TextField(
                controller: scriptController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                maxLines: null,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
