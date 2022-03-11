import 'package:plugpack_flutter/functions/plugin/plugin.dart';

class DirectPlugin extends Plugin {
  final String _downloadLink;

  DirectPlugin(String name, PluginType type, this._downloadLink)
      : super(name, type);

  @override
  String download() {
    return _downloadLink;
  }
}