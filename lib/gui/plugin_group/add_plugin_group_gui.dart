import 'package:flutter/material.dart';
import 'package:plugpack_flutter/functions/plugin_group.dart';
import 'package:plugpack_flutter/functions/plugin/plugin.dart';
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
      Server.selectedServer?.addPluginGroup(_selectedGroup!);
    } else {
      PluginGroup.addPluginGroup(nameController.text);
      Server.selectedServer?.addPluginGroup(PluginGroup.pluginGroups.last);
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

class AddNewPluginGroupGUI extends StatefulWidget {
  const AddNewPluginGroupGUI({Key? key}) : super(key: key);

  @override
  _AddNewPluginGroupGUIState createState() => _AddNewPluginGroupGUIState();
}

class _AddNewPluginGroupGUIState extends State<AddNewPluginGroupGUI> {
  final nameController = TextEditingController();
  bool addFromGroups = false;
  List<bool> selectedGroups =
      List.filled(PluginGroup.pluginGroups.length, false);

  void save(BuildContext context) {
    PluginGroup.addPluginGroup(nameController.text);

    if (addFromGroups) {
      List<PluginGroup> groups = [];
      for (int i = 0; i < selectedGroups.length; i++) {
        if (selectedGroups[i]) {
          groups.add(PluginGroup.pluginGroups[i]);
        }
      }

      List<Plugin> plugins = [];
      for (Plugin plugin in groups.first.plugins) {
        bool contained = true;

        for (PluginGroup group in groups) {
          bool found = false;

          for (Plugin comparePlugin in group.plugins) {
            if (comparePlugin.id == plugin.id) {
              found = true;
            }
          }

          if (!found) {
            contained = false;
          }
        }

        if (contained) {
          plugins.add(plugin);
        }
      }

      for (Plugin plugin in plugins) {
        for (PluginGroup group in groups) {
          group.plugins.remove(plugin);
        }
      }

      for (Server server in Server.servers) {
        bool serverIsAffected = false;

        for (PluginGroup group in groups) {
          if (server.pluginGroups.contains(group)) {
            serverIsAffected = true;
          }
        }

        if (serverIsAffected) {
          server.pluginGroups.add(PluginGroup.pluginGroups.last);
        }
      }

      PluginGroup.pluginGroups.last.plugins = List<Plugin>.from(plugins);
    }
    Navigator.of(context).pop(true);
  }

  void onSwitchToggle(bool toggled) {
    setState(() {
      addFromGroups = toggled;
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
      body: Column(
        children: [
          Expanded(
            child: Form(
              child: Column(
                children: [
                  Container(
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
                    padding: const EdgeInsets.all(10),
                  ),
                  Row(
                    children: [
                      Container(
                        child: const Text(
                          "Transfer plugins from groups: ",
                          style: TextStyle(fontSize: 16),
                        ),
                        padding: const EdgeInsets.only(left: 15, top: 10),
                      ),
                      Container(
                        child: Switch(
                            value: addFromGroups, onChanged: onSwitchToggle),
                        padding: const EdgeInsets.only(top: 10),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: addFromGroups,
                    child: Expanded(
                      child: ListView.builder(
                        itemCount: PluginGroup.pluginGroups.length,
                        itemBuilder: (context, index) {
                          final pluginGroup = PluginGroup.pluginGroups[index];
                          return Card(
                            elevation: 5,
                            color: Colors.teal.shade100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Colors.teal.withOpacity(0.4),
                                width: 1,
                              ),
                            ),
                            margin: const EdgeInsets.all(10),
                            child: CheckboxListTile(
                              title: Text(
                                pluginGroup.groupName,
                                style: const TextStyle(color: Colors.black),
                              ),
                              contentPadding: const EdgeInsets.all(10),
                              onChanged: (bool? enabled) {
                                setState(() {
                                  selectedGroups[index] = enabled!;
                                });
                              },
                              value: selectedGroups[index],
                              activeColor: Colors.blue,
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
