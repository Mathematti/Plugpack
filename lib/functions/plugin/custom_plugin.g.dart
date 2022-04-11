// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_plugin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomPlugin _$CustomPluginFromJson(Map<String, dynamic> json) => CustomPlugin(
      json['name'] as String,
      $enumDecode(_$PluginTypeEnumMap, json['type']),
      json['downloadCommand'] as String,
    );

Map<String, dynamic> _$CustomPluginToJson(CustomPlugin instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': _$PluginTypeEnumMap[instance.type],
      'downloadCommand': instance.downloadCommand,
    };

const _$PluginTypeEnumMap = {
  PluginType.bukkit: 'bukkit',
  PluginType.custom: 'custom',
  PluginType.direct: 'direct',
  PluginType.spigot: 'spigot',
};
