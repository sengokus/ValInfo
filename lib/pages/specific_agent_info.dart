import 'package:flutter/material.dart';

class AgentDetailsPage extends StatelessWidget {
  final String agentName;
  final String agentPhotoUrl;
  final String agentDescription;
  final String agentRole;
  final String agentRoleIcon;
  final String agentRoleDescription;
  //final List<String> agentAbilities;

  const AgentDetailsPage({
    required this.agentName,
    required this.agentPhotoUrl,
    required this.agentDescription,
    required this.agentRole,
    required this.agentRoleIcon,
    required this.agentRoleDescription,
    //required this.agentAbilities,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        'Abilities:',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).textTheme.titleMedium!.color,
                        ),
                      ),
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
                          fontFamily: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .fontFamily,
                          //fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        agentRoleDescription,
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.5,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                top: 10,
                right: 20,
                child: Column(
                  children: [
                    Text(
                      agentName,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.titleMedium!.color,
                        fontFamily:
                            Theme.of(context).textTheme.titleMedium!.fontFamily,
                        fontSize:
                            Theme.of(context).textTheme.titleMedium!.fontSize,
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: SizedBox(
                              width: 20,
                              height: 20,
                              child: Image.network(
                                agentRoleIcon,
                                fit: BoxFit.cover,
                              )),
                        ),
                        Text(
                          agentRole,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
