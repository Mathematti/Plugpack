import 'package:plugpack_flutter/functions/plugin/direct_plugin.dart';
import 'package:plugpack_flutter/functions/plugin/plugin.dart';

class BukkitPlugin extends DirectPlugin {
  BukkitPlugin(String name, PluginType type, String link)
      : super(name, type, _getLink(link));

  static String _getLink(String link) {
    if (link.contains("files/latest")) {
      return link;
    } else if (link.endsWith("/")) {
      return "${link}files/latest";
    } else {
      return "$link/files/latest";
    }
  }
}