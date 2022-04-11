import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:plugpack_flutter/functions/plugin/bukkit_plugin.dart';
import 'package:plugpack_flutter/functions/plugin/custom_plugin.dart';
import 'package:plugpack_flutter/functions/plugin/direct_plugin.dart';
import 'package:plugpack_flutter/functions/plugin/spigot_plugin.dart';

part 'plugin.g.dart';

@JsonSerializable(createFactory: false)
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

  factory Plugin.fromJson(Map<String, dynamic> json) {
    switch (json["type"] as String) {
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