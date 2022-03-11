import 'package:flutter/material.dart';
import 'package:plugpack_flutter/functions/plugin/plugin.dart';
import 'package:plugpack_flutter/functions/plugin/bukkit_plugin.dart';
import 'package:plugpack_flutter/functions/plugin/custom_plugin.dart';
import 'package:plugpack_flutter/functions/plugin/direct_plugin.dart';
import 'package:plugpack_flutter/functions/plugin/spigot_plugin.dart';

class Server {
  static List<Server> servers = [];
  static Server selectedServer = Server("");
  static Plugin selectedPlugin = CustomPlugin("", PluginType.custom, "");

  final String serverName;
  List<Plugin> plugins = [];

  Server(this.serverName);

  static void addServer(String name) {
    servers.add(Server(name));
  }

  void addPlugin(String name, PluginType type, String link) {
    if (type == PluginType.spigot) {
      plugins.add(SpigotPlugin(name, type, link));
    } else if (type == PluginType.bukkit) {
      plugins.add(BukkitPlugin(name, type, link));
    } else if (type == PluginType.direct) {
      plugins.add(DirectPlugin(name, type, link));
    } else if (type == PluginType.custom) {
      plugins.add(CustomPlugin(name, type, link));
    }

    plugins.sort((a, b) => a.name.compareTo(b.name));
  }

  buildTitle(BuildContext context) {
    return Text(
      serverName,
      style: const TextStyle(color: Colors.black),
    );
  }
}
