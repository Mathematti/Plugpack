// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'direct_plugin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectPlugin _$DirectPluginFromJson(Map<String, dynamic> json) => DirectPlugin(
      json['name'] as String,
      $enumDecode(_$PluginTypeEnumMap, json['type']),
      json['downloadLink'] as String,
    );

Map<String, dynamic> _$DirectPluginToJson(DirectPlugin instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': _$PluginTypeEnumMap[instance.type],
      'downloadLink': instance.downloadLink,
    };

const _$PluginTypeEnumMap = {
  PluginType.bukkit: 'bukkit',
  PluginType.custom: 'custom',
  PluginType.direct: 'direct',
  PluginType.spigot: 'spigot',
};
