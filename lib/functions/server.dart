import 'package:json_annotation/json_annotation.dart';
import 'package:plugpack_flutter/functions/plugin_group.dart';

part 'server.g.dart';

@JsonSerializable()
class Server {
  static List<Server> servers = [];
  static Server? selectedServer;

  final String serverName;
  List<PluginGroup> pluginGroups = [];

  Server(this.serverName) {
    servers.add(this);
  }

  static void addServer(String name) {
    Server(name);
  }

  void addPluginGroup(PluginGroup group) {
    pluginGroups.add(group);
  }

  factory Server.fromJson(Map<String, dynamic> json) => _$ServerFromJson(json);
  Map<String, dynamic> toJson() => _$ServerToJson(this);
}
