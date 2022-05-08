import 'package:flutter/material.dart';
import 'package:plugpack_flutter/functions/plugin/plugin.dart';

import 'package:plugpack_flutter/functions/server.dart';
import 'package:plugpack_flutter/functions/plugin_group.dart';

import 'package:plugpack_flutter/gui/plugin/list_plugin_gui.dart';
import 'package:plugpack_flutter/gui/plugin/add_plugin_gui.dart';
import 'package:plugpack_flutter/gui/plugin/modify_plugin_gui.dart';
import 'package:plugpack_flutter/gui/plugin_group/list_plugin_group_gui.dart';
import 'package:plugpack_flutter/gui/plugin_group/add_plugin_group_gui.dart';
import 'package:plugpack_flutter/gui/server/server_gui.dart';
import 'package:plugpack_flutter/gui/server/add_server_gui.dart';
import 'package:plugpack_flutter/gui/script/script_gui.dart';

void main() {
  runApp(Content(key: contentStateKey));
}

class PlugpackMain extends StatefulWidget {
  const PlugpackMain({Key? key}) : super(key: key);

  @override
  createState() => _PlugpackMainState();
}

class _PlugpackMainState extends State<PlugpackMain> {
  int totalPlugins() {
    int plugins = 0;

    for (Server server in Server.servers) {
      for (PluginGroup group in server.pluginGroups) {
        plugins += group.plugins.length;
      }
    }

    return plugins;
  }

  void buttonPress() {
    showLicensePage(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: const Text("Plugpack by Mathematti"),
        actions: [
          IconButton(
            onPressed: buttonPress,
            icon: const Icon(Icons.info_rounded),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            const Text(
              "Current statistics:",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "- ${Server.servers.length} servers\n"
              "- ${PluginGroup.pluginGroups.length} plugin groups\n"
              "- ${totalPlugins()} plugins\n"
              "- ${Plugin.plugins.length} unique plugins\n",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
      ),
      bottomNavigationBar: const NavBar(),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add server",
        onPressed: () {
          Navigator.of(context).pushNamed("/addServer").then((_) {
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  int _currentIndex = contentStateKey.currentState!.index;

  void onTabTapped(int index) {
    contentStateKey.currentState?.updateIndex(index);
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.blueGrey.shade600,
        selectedItemColor: Colors.greenAccent.shade400,
        elevation: 20,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.dns_rounded), label: "Servers"),
          BottomNavigationBarItem(
              icon: Icon(Icons.extension_rounded), label: "Plugin groups"),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment_rounded), label: "Script"),
        ],
        onTap: onTabTapped);
  }
}

class Content extends StatefulWidget {
  const Content({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ContentState();
}

class ContentState extends State<Content> {
  final List _children = [
    const PlugpackMain(),
    const ServerListGUI(),
    const AllPluginGroupListGUI(),
    const ScriptGUI(),
  ];

  void updateIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  int get index {
    return _currentIndex;
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: Builder(
        builder: (context) => _children[_currentIndex],
      ),
      routes: {
        "/addServer": (BuildContext context) => ServerGUI(),
        "/addPluginGroup": (BuildContext context) => const PluginGroupGUI(),
        "/addNewPluginGroup": (BuildContext context) =>
            const AddNewPluginGroupGUI(),
        "/listPluginGroups": (BuildContext context) =>
            const PluginGroupListGUI(),
        "/addPlugin": (BuildContext context) => const AddPluginGUI(),
        "/modifyPlugin": (BuildContext context) => const ModifyPluginGUI(),
        "/listPlugins": (BuildContext context) => const PluginListGUI(),
      },
    );
  }
}

final contentStateKey = GlobalKey<ContentState>();
