import 'dart:convert';
import 'package:plugpack_flutter/functions/server.dart';

class ImportScript {
  static void importScript(String script) {
    String serversString = script.substring(
        script.indexOf("# Plugpack-Config"),
        script.indexOf("# Plugpack-Config-End"));
    List<String> servers = serversString.split("\n");
    servers.removeAt(0);
    servers.removeLast();

    for (String server in servers) {
      Map<String, dynamic> json = jsonDecode(server.substring(2));
      Server.fromJson(json);
    }

  }
}
