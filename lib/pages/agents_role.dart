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
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ),
         
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: agents.length,
              itemBuilder: (context, index) {
                var agent = agents[index];
                String agentFace = agent['displayIcon'];
                String agentPhotoUrl = agent['fullPortrait'];

                // Extracting agent data
                final agentName = agent['displayName'] ?? '';
                final agentDescription = agent['description'] ?? '';
                final agentRoleIcon = agent['role']['displayIcon'] ?? '';
                final agentRoleName = agent['role']['displayName'] ?? '';
                final agentAbility1Name = agent['abilities'][0]['displayName'] ?? '';
                final agentAbility1Icon = agent['abilities'][0]['displayIcon'] ?? '';
                final agentAbility1Description = agent['abilities'][0]['description'] ?? '';
                final agentAbility2Name = agent['abilities'][1]['displayName'] ?? '';
                final agentAbility2Icon = agent['abilities'][1]['displayIcon'] ?? '';
                final agentAbility2Description = agent['abilities'][1]['description'] ?? '';
                final agentAbility3Name = agent['abilities'][2]['displayName'] ?? '';
                final agentAbility3Icon = agent['abilities'][2]['displayIcon'] ?? '';
                final agentAbility3Description = agent['abilities'][2]['description'] ?? '';
                final agentAbility4Name = agent['abilities'][3]['displayName'] ?? '';
                final agentAbility4Icon = agent['abilities'][3]['displayIcon'] ?? '';
                final agentAbility4Description = agent['abilities'][3]['description'] ?? '';

                return GestureDetector(
                  onTap: () {

                    // Navigate to AgentDetailsPage when the card is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AgentDetailsPage(
                          agentName: agentName,
                          agentPhotoUrl: agentPhotoUrl,
                          agentDescription: agentDescription,
                          agentRole: agentRoleName,
                          agentRoleIcon: agentRoleIcon,
                          agentAbility1Name: agentAbility1Name,
                          agentAbility1Icon: agentAbility1Icon,
                          agentAbility1Description: agentAbility1Description,
                          agentAbility2Name: agentAbility2Name,
                          agentAbility2Icon: agentAbility2Icon,
                          agentAbility2Description: agentAbility2Description,
                          agentAbility3Name: agentAbility3Name,
                          agentAbility3Icon: agentAbility3Icon,
                          agentAbility3Description: agentAbility3Description,
                          agentAbility4Name: agentAbility4Name,
                          agentAbility4Icon: agentAbility4Icon,
                          agentAbility4Description: agentAbility4Description, agentRoleDescription: '',
                        ),
                      ),
                    );
                  },
                  child: Card(
                    child: Image.network(agentFace, fit: BoxFit.cover),
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
