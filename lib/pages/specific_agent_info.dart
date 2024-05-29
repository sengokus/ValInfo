import 'package:flutter/material.dart';

class AgentDetailsPage extends StatelessWidget {
  final String agentName;
  final String agentPhotoUrl;
  final String agentDescription;
  final String agentRole;
  //final List<String> agentAbilities;

  const AgentDetailsPage({
    required this.agentName,
    required this.agentPhotoUrl,
    required this.agentDescription,
    required this.agentRole,
    //required this.agentAbilities,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              agentName,
              style: TextStyle(
                color: Theme.of(context).textTheme.titleMedium!.color,
                fontFamily: Theme.of(context).textTheme.titleMedium!.fontFamily,
                fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
              ),
            ),
            Stack(
              children: [
                Image.network(
                  agentPhotoUrl,
                  fit: BoxFit.fitHeight,
                  height: 600,
                ),
                Positioned(
                  bottom: 50,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
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
                          Text(
                            'Role: $agentRole',
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).textTheme.titleMedium!.color, 
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Abilities:',
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).textTheme.titleMedium!.color, 
                            ),
                          ),
                          /*for (var ability in agentAbilities)
                            Text(
                              '- $ability',
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).textTheme.titleMedium!.color, 
                              ),
                            ), */
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
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
