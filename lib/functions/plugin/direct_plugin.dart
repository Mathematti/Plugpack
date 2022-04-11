import 'package:json_annotation/json_annotation.dart';
import 'package:plugpack_flutter/functions/plugin/plugin.dart';

part 'direct_plugin.g.dart';

@JsonSerializable()
class DirectPlugin extends Plugin {
  final String downloadLink;

  DirectPlugin(String name, PluginType type, this.downloadLink)
      : super(name, type);

  @override
  String download() {
    return downloadLink;
  }

  factory DirectPlugin.fromJson(Map<String, dynamic> json) =>
      _$DirectPluginFromJson(json);
  Map<String, dynamic> toJson() => _$DirectPluginToJson(this);
}