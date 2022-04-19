import 'package:json_annotation/json_annotation.dart';
import 'package:plugpack_flutter/functions/generate_id.dart';
import 'package:plugpack_flutter/functions/plugin/bukkit_plugin.dart';
import 'package:plugpack_flutter/functions/plugin/custom_plugin.dart';
import 'package:plugpack_flutter/functions/plugin/direct_plugin.dart';
import 'package:plugpack_flutter/functions/plugin/spigot_plugin.dart';

part 'plugin.g.dart';

@JsonSerializable(createFactory: false)
abstract class Plugin {
  final String name;
  final PluginType type;
  late String id;
  static List<Plugin> plugins = [];

  Plugin(this.name, this.type) {
    plugins.add(this);
    id = GenerateId.generateId(8);
  }

  Plugin.withId(this.name, this.type, this.id) {
    plugins.add(this);
  }

  String download();

  static Plugin? getPluginById(String id) {
    for (Plugin plugin in Plugin.plugins) {
      if (plugin.id == id) {
        return plugin;
      }
    }
    return null;
  }

  factory Plugin.fromJson(Map<String, dynamic> json) {
    Plugin? plugin = getPluginById(json['id']);
    if (plugin != null) {
      return plugin;
    }

    switch (json['type'] as String) {
      case "bukkit":
        return BukkitPlugin.fromJson(json);
      case "custom":
        return CustomPlugin.fromJson(json);
      case "direct":
        return DirectPlugin.fromJson(json);
      case "spigot":
        return SpigotPlugin.fromJson(json);
      default:
        throw StateError("Unknown type ${json['type']} when deserializing type `Plugin`.");
    }
  }
  Map<String, dynamic> toJson() => _$PluginToJson(this);
}

enum PluginType {
  bukkit,
  custom,
  direct,
  spigot
}