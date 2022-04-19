import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:plugpack_flutter/functions/server.dart';
import 'package:plugpack_flutter/main.dart';

class ServerListGUI extends StatefulWidget {
  const ServerListGUI({Key? key}) : super(key: key);

  @override
  _ServerListGUIState createState() => _ServerListGUIState();
}

class _ServerListGUIState extends State<ServerListGUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: const Text("Plugpack - Servers"),
      ),
      body: Column(
        children: [
          Container(
            child: Text(
                Server.servers.isEmpty
                    ? "Please add a server first!"
                    : "Your servers:",
                style: const TextStyle(fontSize: 18)),
            margin: const EdgeInsets.all(20),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: Server.servers.length,
              itemBuilder: (context, index) {
                final server = Server.servers[index];
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
                    title: Text(
                      server.serverName,
                      style: const TextStyle(color: Colors.black),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    onTap: () {
                      Server.selectedServer = server;
                      Navigator.of(context)
                          .pushNamed("/listPluginGroups")
                          .then((_) {
                        setState(() {});
                      });
                      if (kDebugMode) {
                        print(server.serverName);
                      }
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
        tooltip: "Add server",
        onPressed: () {
          Navigator.of(context).pushNamed("/addServer").then((_) {
            setState(() {});
          });
        },
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
