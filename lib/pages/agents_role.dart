import 'package:flutter/material.dart';
import 'package:valinfo/pages/specific_agent_info.dart';

class AgentRolePage extends StatelessWidget {
  final List<dynamic> agents;
  final String role;

  const AgentRolePage({required this.agents, required this.role, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agents'),
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

                return GestureDetector(
                  onTap: () {
                    // Navigate to AgentDetailsPage when the card is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AgentDetailsPage(
                          agentName: agent['displayName'],
                          agentPhotoUrl: agentPhotoUrl,
                          agentDescription: agent['description'],
                          agentRole: role,
                          agentRoleIcon: 'Role Icon URL',
                          agentRoleDescription: 'Role Description',
                          agentAbility1Name: 'Ability 1 Name',
                          agentAbility1Description: 'Ability 1 Description',
                          agentAbility1Icon: 'Ability 1 Icon URL',
                          agentAbility2Name: 'Ability 2 Name',
                          agentAbility2Description: 'Ability 2 Description',
                          agentAbility2Icon: 'Ability 2 Icon URL',
                          agentAbility3Name: 'Ability 3 Name',
                          agentAbility3Description: 'Ability 3 Description',
                          agentAbility3Icon: 'Ability 3 Icon URL',
                          agentAbility4Name: 'Ability 4 Name',
                          agentAbility4Description: 'Ability 4 Description',
                          agentAbility4Icon: 'Ability 4 Icon URL',
                        ),
                      ),
                    );
                  },
                  child: Card(
                    child: Image.network(agentPhotoUrl, fit: BoxFit.cover),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

