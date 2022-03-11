import 'package:flutter/material.dart';
import 'package:plugpack_flutter/gui/script_gui.dart';
import 'package:plugpack_flutter/gui/server_gui.dart';
import 'package:plugpack_flutter/functions/server.dart';
import 'package:plugpack_flutter/gui/plugin_gui.dart';

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
      plugins += server.plugins.length;
    }

    return plugins;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: const Text("Plugpack by Mathematti"),
      ),
      body: Container(
        child: Text(
          "You currently have ${Server.servers.length} servers with "
          "a total of ${totalPlugins()} plugins set up.",
          style: const TextStyle(fontSize: 16),
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
              icon: Icon(Icons.extension_rounded), label: "Plugins"),
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
    const PluginListGUI(),
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
        home: Builder(builder: (context) => _children[_currentIndex]),
        routes: {
          "/addServer": (BuildContext context) => ServerGUI(),
          "/addPlugin": (BuildContext context) => const PluginGUI(),
          "/modifyPlugin": (BuildContext context) => const ModifyPluginGUI(),
        });
  }
}

final contentStateKey = GlobalKey<ContentState>();
