import 'package:flutter/material.dart';

abstract class Plugin {
  final String name;
  final PluginType type;

  Plugin(this.name, this.type);

  String download();

  buildTitle(BuildContext context) {
    return Text(
      name,
      style: const TextStyle(color: Colors.black),
    );
  }
}

enum PluginType {
  bukkit,
  custom,
  direct,
  spigot
}