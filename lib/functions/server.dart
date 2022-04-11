import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:plugpack_flutter/functions/plugin_group.dart';

part 'server.g.dart';

@JsonSerializable()
class Server {
  static List<Server> servers = [];
  static Server selectedServer = Server("");

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

  buildTitle(BuildContext context) {
    return Text(
      serverName,
      style: const TextStyle(color: Colors.black),
    );
  }

  factory Server.fromJson(Map<String, dynamic> json) => _$ServerFromJson(json);
  Map<String, dynamic> toJson() => _$ServerToJson(this);
}
