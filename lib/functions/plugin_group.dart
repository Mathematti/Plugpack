import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:plugpack_flutter/functions/generate_id.dart';
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
  late final String id;
  List<Plugin> plugins = [];

  PluginGroup(this.groupName) {
    id = GenerateId.generateId(8);
    pluginGroups.add(this);
  }

  PluginGroup.withId(this.groupName, this.id) {
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

  static PluginGroup? getGroupById(String id) {
    for (PluginGroup group in PluginGroup.pluginGroups) {
      if (group.id == id) {
        return group;
      }
    }
    return null;
  }

  buildTitle(BuildContext context) {
    return Text(
      groupName,
      style: const TextStyle(color: Colors.black),
    );
  }

  factory PluginGroup.fromJson(Map<String, dynamic> json) {
    PluginGroup? group = getGroupById(json['id'] as String);
    if (group != null) {
      return group;
    }

    return PluginGroup.withId(json['groupName'] as String, json['id'] as String)
      ..plugins = (json['plugins'] as List<dynamic>)
          .map((e) => Plugin.fromJson(e as Map<String, dynamic>))
          .toList();
  }

  Map<String, dynamic> toJson() => _$PluginGroupToJson(this);
}
