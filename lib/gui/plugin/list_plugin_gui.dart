import 'package:flutter/material.dart';
import 'package:plugpack_flutter/functions/plugin_group.dart';
import 'package:plugpack_flutter/functions/server.dart';

class PluginListGUI extends StatefulWidget {
  const PluginListGUI({Key? key}) : super(key: key);

  @override
  _PluginListGUIState createState() => _PluginListGUIState();
}

class _PluginListGUIState extends State<PluginListGUI> {
  void delete() {
    Server.selectedServer?.pluginGroups.remove(PluginGroup.selectedPluginGroup);
    bool isUsed = false;
    for (Server server in Server.servers) {
      if (server.pluginGroups.contains(PluginGroup.selectedPluginGroup)) {
        isUsed = true;
      }
    }

    if (!isUsed) {
      PluginGroup.pluginGroups.remove(PluginGroup.selectedPluginGroup);
    }

    PluginGroup.selectedPluginGroup = null;
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: Text(
            "Plugpack - ${PluginGroup.selectedPluginGroup!.groupName == "" ? "No server selected" : "Plugin group \"" + PluginGroup.selectedPluginGroup!.groupName + "\""}"),
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
                PluginGroup.selectedPluginGroup!.groupName == ""
                    ? "Please select/create a server first!"
                    : "Plugins:",
                style: const TextStyle(fontSize: 18)),
            margin: const EdgeInsets.all(20),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: PluginGroup.selectedPluginGroup!.plugins.length,
              itemBuilder: (context, index) {
                final plugin = PluginGroup.selectedPluginGroup!.plugins[index];
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
                      PluginGroup.selectedPlugin = plugin;
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
