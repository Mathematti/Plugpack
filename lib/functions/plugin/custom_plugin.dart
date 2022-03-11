import 'package:plugpack_flutter/functions/plugin/plugin.dart';

class CustomPlugin extends Plugin {
  final String _downloadCommand;

  CustomPlugin(String name, PluginType type, this._downloadCommand)
      : super(name, type);

  @override
  String download() {
    return _downloadCommand;
  }
}
