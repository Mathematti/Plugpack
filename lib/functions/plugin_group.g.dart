// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plugin_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PluginGroup _$PluginGroupFromJson(Map<String, dynamic> json) => PluginGroup(
      json['groupName'] as String,
    )..plugins = (json['plugins'] as List<dynamic>)
        .map((e) => Plugin.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$PluginGroupToJson(PluginGroup instance) =>
    <String, dynamic>{
      'groupName': instance.groupName,
      'plugins': instance.plugins,
    };
