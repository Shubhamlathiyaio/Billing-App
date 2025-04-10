import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billing/models/config.dart';
import 'package:billing/resources/commons/common_text.dart';
import 'package:billing/views/config/config_field_tile.dart';

class ConfigGroupCard extends StatelessWidget {
  final ConfigGroup group;
  final int index;

  const ConfigGroupCard({super.key, required this.group, required this.index});

  @override
  Widget build(BuildContext context) {
    final expansionController = Get.find<ConfigExpansionController>();
    return Card(
      child: Obx(() {
        return ExpansionTile(
          key: Key("tile_$index"),
          title: CommonText(data: group.title),
          initiallyExpanded: expansionController.openTileIndex.value == index,
          onExpansionChanged: (expanded) =>
              expansionController.toggleTile(index),
          children: group.fields.map((f) => ConfigFieldTile(field: f)).toList(),
        );
      }),
    );
  }
}
