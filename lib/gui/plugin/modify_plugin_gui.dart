import 'package:flutter/material.dart';
import 'package:plugpack_flutter/functions/plugin/plugin.dart';
import 'package:plugpack_flutter/functions/plugin_group.dart';

class ModifyPluginGUI extends StatefulWidget {
  const ModifyPluginGUI({Key? key}) : super(key: key);

  @override
  _ModifyPluginGUIState createState() => _ModifyPluginGUIState();
}

class _ModifyPluginGUIState extends State<ModifyPluginGUI> {
  final nameController =
  TextEditingController(text: PluginGroup.selectedPlugin.name);
  final linkController =
  TextEditingController(text: PluginGroup.selectedPlugin.download());

  PluginType _pluginType = PluginGroup.selectedPlugin.type;

  void save(BuildContext context) {
    PluginGroup.selectedPluginGroup!.plugins.remove(PluginGroup.selectedPlugin);
    PluginGroup.selectedPluginGroup!
        .addPlugin(nameController.text, _pluginType, linkController.text);
    Navigator.of(context).pop(true);
  }

  void delete() {
    PluginGroup.selectedPluginGroup!.plugins.remove(PluginGroup.selectedPlugin);
    Navigator.of(context).pop(true);
  }

  void radioButtonSelected(Object? pluginType) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade700,
        title: Text("Modify plugin \"${PluginGroup.selectedPlugin.name}\" "
            "for server \"${PluginGroup.selectedPluginGroup!.groupName}\""),
        actions: [
          IconButton(
            onPressed: () {
              delete();
            },
            icon: const Icon(
              Icons.delete_forever_rounded,
            ),
          ),
          IconButton(
              onPressed: () {
                save(context);
              },
              icon: const Icon(Icons.save_rounded)),
        ],
      ),
      body: Form(
        child: ListView(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name",
                prefixIcon: const Icon(Icons.drive_file_rename_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                  style: BorderStyle.solid,
                ),
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.format_list_bulleted_rounded,
                    ),
                  ),
                  DropdownButton<PluginType>(
                    elevation: 16,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                    ),
                    dropdownColor: Colors.blueGrey.shade700,
                    value: _pluginType,
                    items: <PluginType>[
                      PluginType.bukkit,
                      PluginType.custom,
                      PluginType.direct,
                      PluginType.spigot
                    ]
                        .map<DropdownMenuItem<PluginType>>(
                            (PluginType value) => DropdownMenuItem<PluginType>(
                          value: value,
                          child: Text(
                            "${value.name[0].toUpperCase()}${value.name.substring(1)}",
                          ),
                        ))
                        .toList(),
                    onChanged: (PluginType? newValue) {
                      setState(() {
                        _pluginType = newValue!;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: TextFormField(
                maxLines: null,
                controller: linkController,
                decoration: InputDecoration(
                  labelText: "Link",
                  prefixIcon: const Icon(
                    Icons.link_rounded,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
          padding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}
