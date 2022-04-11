import 'package:flutter/material.dart';
import 'package:plugpack_flutter/functions/plugin_group.dart';
import 'package:plugpack_flutter/functions/server.dart';
import 'package:plugpack_flutter/main.dart';

class PluginGroupListGUI extends StatefulWidget {
  const PluginGroupListGUI({Key? key}) : super(key: key);

  @override
  _PluginGroupListGUIState createState() => _PluginGroupListGUIState();
}

class _PluginGroupListGUIState extends State<PluginGroupListGUI> {
  void delete() {
    PluginGroup.pluginGroups.remove(PluginGroup.selectedPluginGroup);
    PluginGroup.selectedPluginGroup = null;
    contentStateKey.currentState!.updateIndex(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: Text(
            "Plugpack - ${Server.selectedServer.serverName == ""
                ? "No server selected"
                : "Server \"" + Server.selectedServer.serverName + "\""}"),
        actions: [
          IconButton(
            onPressed: () {
              delete();
            },
            icon: const Icon(Icons.delete_forever_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            child: Text(
              Server.selectedServer.serverName == ""
                  ? "Please select/create a server first!"
                  : "Plugin groups:",
              style: const TextStyle(fontSize: 18),
            ),
            margin: const EdgeInsets.all(20),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: Server.selectedServer.pluginGroups.length,
              itemBuilder: (context, index) {
                final pluginGroup = Server.selectedServer.pluginGroups[index];
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
                  child: ListTile(
                    title: pluginGroup.buildTitle(context),
                    contentPadding: const EdgeInsets.all(10),
                    onTap: () {
                      PluginGroup.selectedPluginGroup = pluginGroup;
                      Navigator.of(context).pushNamed("/listPlugins").then(
                            (_) {
                          setState(() {});
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add plugin group",
        onPressed: () {
          Navigator.of(context).pushNamed("/addPluginGroup").then((_) {
            setState(() {});
          });
        },
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}

class AllPluginGroupListGUI extends StatefulWidget {
  const AllPluginGroupListGUI({Key? key}) : super(key: key);

  @override
  _AllPluginGroupListGUIState createState() => _AllPluginGroupListGUIState();
}

class _AllPluginGroupListGUIState extends State<AllPluginGroupListGUI> {
  void delete() {
    PluginGroup.pluginGroups.remove(PluginGroup.selectedPluginGroup);
    PluginGroup.selectedPluginGroup = null;
    contentStateKey.currentState!.updateIndex(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: const Text("Plugpack - Plugin groups"),
      ),
      body: Column(
        children: [
          Container(
            child: Text(
                PluginGroup.pluginGroups.isNotEmpty
                    ? "Plugin groups:"
                    : "No plugin groups set up!",
                style: const TextStyle(fontSize: 18)),
            margin: const EdgeInsets.all(20),
          ),
          Expanded(
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
                  child: ListTile(
                    title: pluginGroup.buildTitle(context),
                    contentPadding: const EdgeInsets.all(10),
                    onTap: () {
                      PluginGroup.selectedPluginGroup = pluginGroup;
                      Navigator.of(context).pushNamed("/listPlugins").then((_) {
                        setState(() {});
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NavBar(),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add plugin group",
        onPressed: () {
          Navigator.of(context).pushNamed("/addPluginGroup").then((_) {
            setState(() {});
          });
        },
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}

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
