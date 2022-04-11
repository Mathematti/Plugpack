// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bukkit_plugin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BukkitPlugin _$BukkitPluginFromJson(Map<String, dynamic> json) => BukkitPlugin(
      json['name'] as String,
      $enumDecode(_$PluginTypeEnumMap, json['type']),
      json['link'] as String,
    );

Map<String, dynamic> _$BukkitPluginToJson(BukkitPlugin instance) =>
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
