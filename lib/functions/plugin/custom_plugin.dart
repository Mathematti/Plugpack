import 'package:json_annotation/json_annotation.dart';
import 'package:plugpack_flutter/functions/plugin/plugin.dart';

part 'custom_plugin.g.dart';

@JsonSerializable()
class CustomPlugin extends Plugin {
  final String downloadCommand;

  CustomPlugin(String name, PluginType type, this.downloadCommand)
      : super(name, type);

  @override
  String download() {
    return downloadCommand;
  }

  factory CustomPlugin.fromJson(Map<String, dynamic> json) =>
      _$CustomPluginFromJson(json);
  Map<String, dynamic> toJson() => _$CustomPluginToJson(this);
}
