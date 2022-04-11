import 'package:flutter/material.dart';
import 'package:plugpack_flutter/functions/plugin_group.dart';
import 'package:plugpack_flutter/functions/server.dart';

class PluginGroupGUI extends StatefulWidget {
  const PluginGroupGUI({Key? key}) : super(key: key);

  @override
  _PluginGroupGUIState createState() => _PluginGroupGUIState();
}

class _PluginGroupGUIState extends State<PluginGroupGUI> {
  final nameController = TextEditingController();
  bool addExisting = false;
  PluginGroup? _selectedGroup;

  void save(BuildContext context) {
    if (addExisting) {
      Server.selectedServer.addPluginGroup(_selectedGroup!);
    } else {
      PluginGroup.addPluginGroup(nameController.text);
      Server.selectedServer.addPluginGroup(PluginGroup.pluginGroups.last);
    }
    Navigator.of(context).pop(true);
  }

  void onSwitchToggle(bool toggled) {
    setState(() {
      addExisting = toggled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add plugin group"),
        actions: [
          IconButton(
              onPressed: () {
                save(context);
              },
              icon: const Icon(Icons.save_rounded)),
        ],
      ),
      body: Column(children: [
        Row(
          children: [
            Container(
              child: const Text(
                "Add existing: ",
                style: TextStyle(fontSize: 16),
              ),
              padding: const EdgeInsets.only(left: 15, top: 10),
            ),
            Container(
              child: Switch(value: addExisting, onChanged: onSwitchToggle),
              padding: const EdgeInsets.only(top: 10),
            ),
          ],
        ),
        Expanded(
          child: Form(
            child: ListView(
              children: [
                Visibility(
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Name",
                      prefixIcon:
                      const Icon(Icons.drive_file_rename_outline_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  replacement: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey.shade600,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.format_list_bulleted_rounded,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 1),
                          child: DropdownButton<PluginGroup>(
                            value: _selectedGroup,
                            elevation: 16,
                            icon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                            ),
                            dropdownColor: Colors.blueGrey.shade700,
                            items: PluginGroup.pluginGroups
                                .map<DropdownMenuItem<PluginGroup>>(
                                    (PluginGroup value) =>
                                    DropdownMenuItem<PluginGroup>(
                                      value: value,
                                      child: Text(
                                        value.groupName,
                                      ),
                                    ))
                                .toList(),
                            onChanged: (PluginGroup? newValue) {
                              setState(() {
                                _selectedGroup = newValue!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  visible: !addExisting,
                )
              ],
              padding: const EdgeInsets.all(10),
            ),
          ),
        ),
      ]),
    );
  }
}
