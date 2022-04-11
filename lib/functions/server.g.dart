// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Server _$ServerFromJson(Map<String, dynamic> json) => Server(
      json['serverName'] as String,
    )..pluginGroups = (json['pluginGroups'] as List<dynamic>)
        .map((e) => PluginGroup.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$ServerToJson(Server instance) => <String, dynamic>{
      'serverName': instance.serverName,
      'pluginGroups': instance.pluginGroups,
    };
