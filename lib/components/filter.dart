import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:valinfo/components/agent_tabbar.dart';
import 'package:valinfo/pages/agents_role.dart';

class FilterButton extends StatelessWidget {
  final void Function(String) onSelected;

  const FilterButton({required this.onSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 40),
      onSelected: onSelected,
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem(value: 'Duelist', child: Text('Duelist')),
          const PopupMenuItem(value: 'Initiator', child: Text('Initiator')),
          const PopupMenuItem(value: 'Controller', child: Text('Controller')),
          const PopupMenuItem(value: 'Sentinel', child: Text('Sentinel')),
        ];
      },
      child: const Row(
        children: [
          Text('Filter'),
          SizedBox(width: 5),
          Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }
}
