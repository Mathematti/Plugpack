import 'package:plugpack_flutter/functions/server.dart';
import 'package:plugpack_flutter/functions/plugin/plugin.dart';
import 'package:plugpack_flutter/functions/plugin/custom_plugin.dart';
import 'package:plugpack_flutter/functions/plugin/direct_plugin.dart';
import 'package:plugpack_flutter/functions/plugin/spigot_plugin.dart';

class GenerateScript {
  static String generateScript() {
    StringBuffer config = StringBuffer("# Servers: ");
    for (Server server in Server.servers) {
      config.write("${server.serverName},");
    }
    config.writeln(" ServersEnd");

    for (Server server in Server.servers) {
      config.write("# ${server.serverName}-SpigotPlugins: ");
      for (Plugin plugin in server.plugins) {
        if (plugin is SpigotPlugin) {
          config.write("${plugin.name}:.${plugin.id}/,");
        }
      }
      config.writeln(" ${server.serverName}-SpigotPluginsEnd");

      config.write("# ${server.serverName}-DirectPlugins: ");
      for (Plugin plugin in server.plugins) {
        if (plugin is DirectPlugin) {
          config.write("${plugin.name}:${plugin.download()},");
        }
      }
      config.writeln(" ${server.serverName}-DirectPluginsEnd");

      config.write("# ${server.serverName}-CustomPlugins: ");
      for (Plugin plugin in server.plugins) {
        if (plugin is CustomPlugin) {
          config.write(
              "${plugin.name}:${plugin.download().replaceAll("\n", "@plclb@")}@plcs@");
        }
      }
      config.writeln(" ${server.serverName}-CustomPluginsEnd");
    }
    config.writeln();
    config.writeln("sudo rm -f -r /var/lib/Plugpack/*");
    config.writeln();

    StringBuffer output = StringBuffer(config.toString());

    for (Server server in Server.servers) {
      output.writeln(
          "sudo mkdir -p /var/lib/Plugpack/plugins/${server.serverName}/");
      output.writeln("cd /var/lib/Plugpack/plugins/${server.serverName}/");

      for (Plugin plugin in server.plugins) {
        if (plugin is DirectPlugin) {
          String pluginLink = plugin.download();

          output.writeln("sudo wget $pluginLink");

          if (pluginLink.endsWith("/")) {
            pluginLink = pluginLink.substring(0, pluginLink.length - 1);
          }
          output.writeln(
              "sudo mv ./${pluginLink.substring(pluginLink.lastIndexOf("/") + 1)}"
              " ./${plugin.name.replaceAll(" ", "")}.jar");
        } else if (plugin is CustomPlugin) {
          output.writeln(plugin.download());
        } else if (plugin is SpigotPlugin) {
          output.writeln(
              "sudo wget https://api.spiget.org/v2/resources/${plugin.id}/download");
          output.writeln(
              "sudo mv ./download ./${plugin.name.replaceAll(" ", "")}.jar");
        }
      }

      output.writeln("cd ../../../");
    }

    output.writeln("sudo mkdir /var/lib/Plugpack/out/");

    for (Server server in Server.servers) {
      output.writeln("cd /var/lib/Plugpack/plugins/${server.serverName}/");
      output.writeln("sudo zip ../../out/${server.serverName}.zip ./*");
      output.writeln("cd ../../../");
    }

    return output.toString();
  }
}
