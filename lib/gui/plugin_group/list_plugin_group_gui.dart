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
          Navigator.of(context).pushNamed("/addNewPluginGroup").then((_) {
            setState(() {});
          });
        },
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
