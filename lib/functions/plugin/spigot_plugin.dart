import 'package:plugpack_flutter/functions/plugin/plugin.dart';

class SpigotPlugin extends Plugin {
  late final String id;
  late final String _link;

  SpigotPlugin(String name, PluginType type, this._link)
      : id = _link.substring(_link.lastIndexOf('.') + 1, _link.length - 1),
        super(name, type);

  @override
  String download() {
    return _link;
  }
}
