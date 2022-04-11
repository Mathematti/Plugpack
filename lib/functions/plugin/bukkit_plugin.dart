import 'package:json_annotation/json_annotation.dart';
import 'package:plugpack_flutter/functions/plugin/direct_plugin.dart';
import 'package:plugpack_flutter/functions/plugin/plugin.dart';

part 'bukkit_plugin.g.dart';

@JsonSerializable()
class BukkitPlugin extends DirectPlugin {
  String link;

  BukkitPlugin(String name, PluginType type, this.link)
      : super(name, type, _getLink(link));

  static String _getLink(String link) {
    if (link.contains("files/latest")) {
      return link;
    } else if (link.endsWith("/")) {
      return "${link}files/latest";
    } else {
      return "$link/files/latest";
    }
  }

  factory BukkitPlugin.fromJson(Map<String, dynamic> json) =>
      _$BukkitPluginFromJson(json);
  Map<String, dynamic> toJson() => _$BukkitPluginToJson(this);
}