import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:plugpack_flutter/functions/plugin/plugin.dart';
import 'package:plugpack_flutter/functions/plugin/bukkit_plugin.dart';
import 'package:plugpack_flutter/functions/plugin/custom_plugin.dart';
import 'package:plugpack_flutter/functions/plugin/direct_plugin.dart';
import 'package:plugpack_flutter/functions/plugin/spigot_plugin.dart';

part 'plugin_group.g.dart';

@JsonSerializable()
class PluginGroup {
  static List<PluginGroup> pluginGroups = [];
  static PluginGroup? selectedPluginGroup;
  static Plugin selectedPlugin = CustomPlugin("", PluginType.custom, "");

  final String groupName;
  List<Plugin> plugins = [];

  PluginGroup(this.groupName) {
    pluginGroups.add(this);
  }

  static void addPluginGroup(String name) {
    if (name != "") {
      PluginGroup(name);
    }
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
      groupName,
      style: const TextStyle(color: Colors.black),
    );
  }

  factory PluginGroup.fromJson(Map<String, dynamic> json) =>
      _$PluginGroupFromJson(json);
  Map<String, dynamic> toJson() => _$PluginGroupToJson(this);
}
