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

    // Use Obx here to rebuild the full widget when tile index changes
    return Obx(() {
      final isExpanded = expansionController.openTileIndex.value == index;

      return Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: ExpansionTile(
          key: Key("tile_$index-${isExpanded.toString()}"), // Important: force rebuild
          title: CommonText(data: group.title),
          backgroundColor: Colors.white,
          collapsedBackgroundColor: Colors.grey.shade100,
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          trailing: AnimatedRotation(
            turns: isExpanded ? 0.5 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: const Icon(Icons.arrow_drop_down_rounded, size: 28),
          ),
          initiallyExpanded: isExpanded,
          onExpansionChanged: (expanded) {
            expansionController.toggleTile(index);
          },
          children: group.fields.map((f) => ConfigFieldTile(field: f)).toList(),
        ),
      );
    });
  }
}
