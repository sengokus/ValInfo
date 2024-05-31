import 'package:flutter/material.dart';

class AgentAbilities extends StatefulWidget {
  final List<Map<String, String>> abilities;
  final Function(String, String) onAbilityClicked;

  const AgentAbilities({
    required this.abilities,
    required this.onAbilityClicked,
    super.key,
  }) ;

  @override
  _AgentAbilitiesState createState() => _AgentAbilitiesState();
}

class _AgentAbilitiesState extends State<AgentAbilities> {
  String? selectedAbility; // Track the currently selected ability

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.abilities.map((ability) {
          return GestureDetector(
            onTap: () {
              setState(() {
                // Update the selected ability
                selectedAbility = ability['name'];
              });
              widget.onAbilityClicked(ability['name']!, ability['description']!);
            },
            child: _buildAbilityBox(ability),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAbilityBox(Map<String, String> ability) {
    final isSelected = ability['name'] == selectedAbility;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: isSelected ? Theme.of(context).indicatorColor : Colors.black54,
        border: Border.all(
          color: Colors.grey[400]!,
          width: 1.0,
        ),
      ),
      child: Center(
        child: Image.network(
          ability['icon']!,
          width: 32,
          height: 32,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
