import 'package:flutter/material.dart';

class AgentAbilities extends StatelessWidget {
  final List<Map<String, String>> abilities;
  final Function(String, String) onAbilityClicked;

  const AgentAbilities({
    required this.abilities,
    required this.onAbilityClicked,
    super.key,
  }) ;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: abilities.map((ability) {
          return GestureDetector(
            onTap: () {
              onAbilityClicked(ability['name']!, ability['description']!);
            },
            child: _buildAbilityBox(ability['icon']!),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAbilityBox(String iconUrl) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black54,
        border: Border.all(
          color: Colors.grey[400]!,
          width: 1.0,
        ),
      ),
      child: Center(
        child: Image.network(
          iconUrl,
          width: 32,
          height: 32,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
