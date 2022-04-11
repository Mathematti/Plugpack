import 'package:json_annotation/json_annotation.dart';
import 'package:plugpack_flutter/functions/plugin/plugin.dart';

part 'spigot_plugin.g.dart';

@JsonSerializable()
class SpigotPlugin extends Plugin {
  final String id;
  final String link;

  SpigotPlugin(String name, PluginType type, this.link)
      : id = link.substring(link.lastIndexOf('.') + 1, link.length - 1),
        super(name, type);

  @override
  String download() {
    return link;
  }

  factory SpigotPlugin.fromJson(Map<String, dynamic> json) =>
      _$SpigotPluginFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SpigotPluginToJson(this);
}
