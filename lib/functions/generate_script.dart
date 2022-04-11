import 'dart:convert';

import 'package:plugpack_flutter/functions/plugin_group.dart';
import 'package:plugpack_flutter/functions/plugin/plugin.dart';
import 'package:plugpack_flutter/functions/plugin/custom_plugin.dart';
import 'package:plugpack_flutter/functions/plugin/direct_plugin.dart';
import 'package:plugpack_flutter/functions/plugin/spigot_plugin.dart';
import 'package:plugpack_flutter/functions/server.dart';

class GenerateScript {
  static String generateScript() {
    StringBuffer config = StringBuffer("# Plugpack-Config\n");

    for (Server server in Server.servers) {
      config.writeln("# ${jsonEncode(server)}");
    }

    config.writeln("# Plugpack-Config-End");
    config.writeln();

    // Actual execution
    StringBuffer output = StringBuffer(config.toString());
    output.writeln("sudo rm -rf /var/lib/Plugpack/*");
    output.writeln();

    for (Server server in Server.servers) {
      output.writeln(
          "sudo mkdir -p /var/lib/Plugpack/plugins/${server.serverName}/");
      output.writeln("cd /var/lib/Plugpack/plugins/${server.serverName}/");

      for (PluginGroup group in server.pluginGroups) {
        for (Plugin plugin in group.plugins) {
          if (plugin is DirectPlugin) {
            String pluginLink = plugin.download();

            output.writeln("sudo wget $pluginLink");

            if (pluginLink.endsWith("/")) {
              pluginLink = pluginLink.substring(0, pluginLink.length - 1);
            }
            output.writeln(
                "sudo mv ./${pluginLink.substring(
                    pluginLink.lastIndexOf("/") + 1)}"
                    " ./${plugin.name.replaceAll(" ", "")}.jar");
          } else if (plugin is CustomPlugin) {
            output.writeln(plugin.download());
          } else if (plugin is SpigotPlugin) {
            output.writeln(
                "sudo wget https://api.spiget.org/v2/resources/${plugin
                    .id}/download");
            output.writeln(
                "sudo mv ./download ./${plugin.name.replaceAll(" ", "")}.jar");
          }
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
