import 'package:flutter/material.dart';
import 'package:plugpack_flutter/functions/plugin_group.dart';
import 'package:plugpack_flutter/functions/plugin/plugin.dart';

class AddPluginGUI extends StatefulWidget {
  const AddPluginGUI({Key? key}) : super(key: key);

  @override
  State<AddPluginGUI> createState() => _AddPluginGUIState();
}

class _AddPluginGUIState extends State<AddPluginGUI> {
  final nameController = TextEditingController();
  final linkController = TextEditingController();

  PluginType _pluginType = PluginType.custom;

  void save(BuildContext context) {
    PluginGroup.selectedPluginGroup!
        .addPlugin(nameController.text, _pluginType, linkController.text);
    Navigator.of(context).pop(true);
  }

  void radioButtonSelected(Object? pluginType) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade700,
        title:
        Text("Add plugin to ${PluginGroup.selectedPluginGroup!.groupName}"),
        actions: [
          IconButton(
            onPressed: () {
              save(context);
            },
            icon: const Icon(Icons.save_rounded),
          ),
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
