import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String agentDescription;
  final String agentRole;
  final String agentRoleDescription;

  const InfoCard({
    required this.agentDescription,
    required this.agentRole,
    required this.agentRoleDescription,
    super.key,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black54,
        border: Border(
          top: BorderSide(
            color: Colors.white,
            width: 1.0,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(
            agentDescription,
            style: TextStyle(
              fontSize: 15,
              height: 1.5,
              color: Theme.of(context).textTheme.titleMedium!.color,
            ),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 10),
          Text(
            agentRole.toUpperCase(),
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.titleMedium!.fontFamily,
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          Text(
            agentRoleDescription,
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
              color: Colors.white,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
