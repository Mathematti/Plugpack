// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spigot_plugin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpigotPlugin _$SpigotPluginFromJson(Map<String, dynamic> json) => SpigotPlugin(
      json['name'] as String,
      $enumDecode(_$PluginTypeEnumMap, json['type']),
      json['link'] as String,
    );

Map<String, dynamic> _$SpigotPluginToJson(SpigotPlugin instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': _$PluginTypeEnumMap[instance.type],
      'link': instance.link,
    };

const _$PluginTypeEnumMap = {
  PluginType.bukkit: 'bukkit',
  PluginType.custom: 'custom',
  PluginType.direct: 'direct',
  PluginType.spigot: 'spigot',
};
