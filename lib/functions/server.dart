import 'package:flutter/material.dart';
import 'package:plugpack_flutter/functions/plugin_group.dart';

class Server {
  static List<Server> servers = [];
  static Server selectedServer = Server("");

  final String serverName;
  List<PluginGroup> pluginGroups = [];

  Server(this.serverName) {
    PluginGroup.addPluginGroup(serverName);
    addPluginGroup(PluginGroup.pluginGroups.last);
  }

  static void addServer(String name) {
    servers.add(Server(name));
  }

  void addPluginGroup(PluginGroup group) {
    pluginGroups.add(group);
  }

  buildTitle(BuildContext context) {
    return Text(
      serverName,
      style: const TextStyle(color: Colors.black),
    );
  }
}
