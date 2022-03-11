import 'package:flutter/material.dart';
import 'package:plugpack_flutter/functions/plugin/plugin.dart';
import 'package:plugpack_flutter/functions/server.dart';
import 'package:plugpack_flutter/main.dart';

class PluginListGUI extends StatefulWidget {
  const PluginListGUI({Key? key}) : super(key: key);

  @override
  _PluginListGUIState createState() => _PluginListGUIState();
}

class _PluginListGUIState extends State<PluginListGUI> {
  void delete() {
    Server.servers.remove(Server.selectedServer);
    Server.selectedServer = Server("");
    contentStateKey.currentState!.updateIndex(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: Text(
            "Plugpack - ${Server.selectedServer.serverName == "" ? "No server selected" : "Server \"" + Server.selectedServer.serverName + "\""}"),
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
                    : "Plugins:",
                style: const TextStyle(fontSize: 18)),
            margin: const EdgeInsets.all(20),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: Server.selectedServer.plugins.length,
              itemBuilder: (context, index) {
                final plugin = Server.selectedServer.plugins[index];
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
                    title: plugin.buildTitle(context),
                    contentPadding: const EdgeInsets.all(10),
                    onTap: () {
                      Server.selectedPlugin = plugin;
                      Navigator.of(context)
                          .pushNamed("/modifyPlugin")
                          .then((_) {
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
        tooltip: "Add plugin",
        onPressed: () {
          Navigator.of(context).pushNamed("/addPlugin").then((_) {
            setState(() {});
          });
        },
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}

class PluginGUI extends StatefulWidget {
  const PluginGUI({Key? key}) : super(key: key);

  @override
  State<PluginGUI> createState() => _PluginGUIState();
}

class _PluginGUIState extends State<PluginGUI> {
  final nameController = TextEditingController();
  final linkController = TextEditingController();

  PluginType _pluginType = PluginType.custom;

  void save(BuildContext context) {
    Server.selectedServer
        .addPlugin(nameController.text, _pluginType, "https://myriadical.com");
    Navigator.of(context).pop(true);
  }

  void radioButtonSelected(Object? pluginType) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade700,
        title: Text("Add plugin to ${Server.selectedServer.serverName}"),
        actions: [
          IconButton(
            onPressed: () {
              save(context);
            },
            icon: const Icon(Icons.save_rounded),
          ),
        ],
      ),
      body: Form(
        child: ListView(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name",
                prefixIcon: const Icon(Icons.drive_file_rename_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
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
                  DropdownButton<PluginType>(
                    elevation: 16,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                    ),
                    dropdownColor: Colors.blueGrey.shade700,
                    value: _pluginType,
                    items: <PluginType>[
                      PluginType.bukkit,
                      PluginType.custom,
                      PluginType.direct,
                      PluginType.spigot
                    ]
                        .map<DropdownMenuItem<PluginType>>(
                            (PluginType value) => DropdownMenuItem<PluginType>(
                                  value: value,
                                  child: Text(
                                    "${value.name[0].toUpperCase()}${value.name.substring(1)}",
                                  ),
                                ))
                        .toList(),
                    onChanged: (PluginType? newValue) {
                      setState(() {
                        _pluginType = newValue!;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: TextFormField(
                controller: linkController,
                decoration: InputDecoration(
                  labelText: "Link",
                  prefixIcon: const Icon(
                    Icons.link_rounded,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
          padding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}

class ModifyPluginGUI extends StatefulWidget {
  const ModifyPluginGUI({Key? key}) : super(key: key);

  @override
  _ModifyPluginGUIState createState() => _ModifyPluginGUIState();
}

class _ModifyPluginGUIState extends State<ModifyPluginGUI> {
  final nameController =
      TextEditingController(text: Server.selectedPlugin.name);
  final linkController =
      TextEditingController(text: Server.selectedPlugin.download());

  PluginType _pluginType = Server.selectedPlugin.type;

  void save(BuildContext context) {
    Server.selectedServer.plugins.remove(Server.selectedPlugin);
    Server.selectedServer
        .addPlugin(nameController.text, _pluginType, "https://myriadical.com");
    Navigator.of(context).pop(true);
  }

  void delete() {
    Server.selectedServer.plugins.remove(Server.selectedPlugin);
    Navigator.of(context).pop(true);
  }

  void radioButtonSelected(Object? pluginType) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade700,
        title: Text("Modify plugin \"${Server.selectedPlugin.name}\" "
            "for server \"${Server.selectedServer.serverName}\""),
        actions: [
          IconButton(
            onPressed: () {
              delete();
            },
            icon: const Icon(
              Icons.delete_forever_rounded,
            ),
          ),
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
                prefixIcon: const Icon(Icons.drive_file_rename_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
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
                  DropdownButton<PluginType>(
                    elevation: 16,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                    ),
                    dropdownColor: Colors.blueGrey.shade700,
                    value: _pluginType,
                    items: <PluginType>[
                      PluginType.bukkit,
                      PluginType.custom,
                      PluginType.direct,
                      PluginType.spigot
                    ]
                        .map<DropdownMenuItem<PluginType>>(
                            (PluginType value) => DropdownMenuItem<PluginType>(
                                  value: value,
                                  child: Text(
                                    "${value.name[0].toUpperCase()}${value.name.substring(1)}",
                                  ),
                                ))
                        .toList(),
                    onChanged: (PluginType? newValue) {
                      setState(() {
                        _pluginType = newValue!;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: TextFormField(
                maxLines: null,
                controller: linkController,
                decoration: InputDecoration(
                  labelText: "Link",
                  prefixIcon: const Icon(
                    Icons.link_rounded,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
          padding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}
