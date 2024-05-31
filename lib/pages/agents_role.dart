import 'package:flutter/material.dart';

class AgentRolePage extends StatelessWidget {
  final List<dynamic> agents;
  final String role;

  const AgentRolePage({required this.agents, required this.role, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agents with role: $role'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              role,
              style: Theme.of(context).textTheme.titleMedium,  // Apply the custom text style
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Adjust as needed
                childAspectRatio: 1.0,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: agents.length,
              itemBuilder: (context, index) {
                var agent = agents[index];
                String agentPhotoUrl = agent['displayIcon'];

                return Card(
                  child: Image.network(agentPhotoUrl, fit: BoxFit.cover),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
