import 'package:plugpack_flutter/functions/plugin/plugin.dart';
import 'package:plugpack_flutter/functions/server.dart';

class ImportScript {
  static void importScript(String script) {
    String serversString = script.substring(
        script.indexOf("# Servers: ") + "# Servers: ".length,
        script.indexOf(" ServersEnd"));
    List<String> servers = serversString.split(",");
    servers.removeLast();

    for (String server in servers) {
      Server.addServer(server);

      String spigotPluginString = script.substring(
          (script.indexOf("# " + server + "-SpigotPlugins: ") +
              ("# " + server + "-SpigotPlugins: ").length),
          script.indexOf(" " + server + "-SpigotPluginsEnd"));
      List<String> spigotPlugins = spigotPluginString.split(",");
      spigotPlugins.removeLast();
      for (String plugin in spigotPlugins) {
        try {
          Server.servers[Server.servers.length - 1].addPlugin(
              plugin.substring(0, plugin.indexOf(":")),
              PluginType.spigot,
              plugin.substring(plugin.indexOf(":") + 1));
        } on Exception catch (_) {}
      }

      String directPluginString = script.substring(
          (script.indexOf("# " + server + "-DirectPlugins: ") +
              ("# " + server + "-DirectPlugins: ").length),
          script.indexOf(" " + server + "-DirectPluginsEnd"));
      List<String> directPlugins = directPluginString.split(",");
      directPlugins.removeLast();
      for (String plugin in directPlugins) {
        try {
          Server.servers[Server.servers.length - 1].addPlugin(
              plugin.substring(0, plugin.indexOf(":")),
              PluginType.direct,
              plugin.substring(plugin.indexOf(":") + 1));
        } on Exception catch (_) {}
      }

      String customPluginString = script.substring(
          (script.indexOf("# " + server + "-CustomPlugins: ") +
              ("# " + server + "-CustomPlugins: ").length),
          script.indexOf(" " + server + "-CustomPluginsEnd"));
      List<String> customPlugins = customPluginString.split("@plcs@");
      customPlugins.removeLast();
      for (String plugin in customPlugins) {
        try {
          Server.servers[Server.servers.length - 1].addPlugin(
              plugin.substring(0, plugin.indexOf(":")),
              PluginType.custom,
              plugin
                  .substring(plugin.indexOf(":") + 1)
                  .replaceAll("@plclb@", "\n"));
        } on Exception catch (_) {}
      }
    }

    for (Server server in Server.servers) {
      server.plugins.sort((a, b) => a.name.compareTo(b.name));
    }
  }
}
