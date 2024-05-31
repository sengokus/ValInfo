import 'package:flutter/material.dart';
import 'package:valinfo/pages/specific_agent_info.dart';

class AgentRolePage extends StatelessWidget {
  final List<dynamic> agents;
  final String role;

  const AgentRolePage({required this.agents, required this.role, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Agents',
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
            fontFamily: Theme.of(context).textTheme.titleSmall!.fontFamily,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff3e606c), Color(0xff4c7a8a), Color(0xff222042)],
            stops: [0, 0.12, 1],
            begin: Alignment(-0.4, -1.0),
            end: Alignment(1.9, 2.3),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50.0),
            Text(
              role.toUpperCase(),
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.titleMedium!.fontFamily,
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
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
                  final agentAbility1Name =
                      agent['abilities'][0]['displayName'] ?? '';
                  final agentAbility1Icon =
                      agent['abilities'][0]['displayIcon'] ?? '';
                  final agentAbility1Description =
                      agent['abilities'][0]['description'] ?? '';
                  final agentAbility2Name =
                      agent['abilities'][1]['displayName'] ?? '';
                  final agentAbility2Icon =
                      agent['abilities'][1]['displayIcon'] ?? '';
                  final agentAbility2Description =
                      agent['abilities'][1]['description'] ?? '';
                  final agentAbility3Name =
                      agent['abilities'][2]['displayName'] ?? '';
                  final agentAbility3Icon =
                      agent['abilities'][2]['displayIcon'] ?? '';
                  final agentAbility3Description =
                      agent['abilities'][2]['description'] ?? '';
                  final agentAbility4Name =
                      agent['abilities'][3]['displayName'] ?? '';
                  final agentAbility4Icon =
                      agent['abilities'][3]['displayIcon'] ?? '';
                  final agentAbility4Description =
                      agent['abilities'][3]['description'] ?? '';

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
                            agentAbility4Description: agentAbility4Description,
                            agentRoleDescription: '',
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
      ),
    );
  }
}
