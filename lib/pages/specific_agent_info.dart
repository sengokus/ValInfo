import 'dart:developer';

import 'package:flutter/material.dart';

class AgentDetailsPage extends StatelessWidget {
  final String agentName;
  final String agentPhotoUrl;
  final String agentDescription;
  final String agentRole;
  final String agentRoleIcon;
  final String agentRoleDescription;

  final String agentAbility1Name;
  final String agentAbility1Description;
  final String agentAbility1Icon;

  final String agentAbility2Name;
  final String agentAbility2Description;
  final String agentAbility2Icon;

  final String agentAbility3Name;
  final String agentAbility3Description;
  final String agentAbility3Icon;

  final String agentAbility4Name;
  final String agentAbility4Description;
  final String agentAbility4Icon;
  //final List<String> agentAbilities;

  const AgentDetailsPage({
    required this.agentName,
    required this.agentPhotoUrl,
    required this.agentDescription,
    required this.agentRole,
    required this.agentRoleIcon,
    required this.agentRoleDescription,
    required this.agentAbility1Name,
    required this.agentAbility1Description,
    required this.agentAbility1Icon,
    required this.agentAbility2Name,
    required this.agentAbility2Description,
    required this.agentAbility2Icon,
    required this.agentAbility3Name,
    required this.agentAbility3Description,
    required this.agentAbility3Icon,
    required this.agentAbility4Name,
    required this.agentAbility4Description,
    required this.agentAbility4Icon,
    super.key,
    //required this.agentAbilities,
  });

  @override
  Widget build(BuildContext context) {
    log("Role: $agentRole : $agentRoleIcon");
    log("Role Description: $agentRoleDescription");

    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Image.network(
              agentPhotoUrl,
              fit: BoxFit.fitHeight,
              height: 800,
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
                        agentRole != 'Loading'
                            ? agentRole.toUpperCase()
                            : 'INITIATOR',
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
                        agentRoleDescription != 'Loading'
                            ? agentRoleDescription
                            : 'Initiators challenge angles by setting up their team to enter contested ground and push defenders away.',
                        style: const TextStyle(
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      agentName,
                      style: TextStyle(
                        height: 1.0,
                        color: Theme.of(context).textTheme.titleMedium!.color,
                        fontFamily:
                            Theme.of(context).textTheme.titleMedium!.fontFamily,
                        fontSize:
                            Theme.of(context).textTheme.titleMedium!.fontSize,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: SizedBox(
                              width: 12,
                              height: 12,
                              child: Image.network(
                                agentRoleIcon != 'Loading'
                                    ? agentRoleIcon
                                    : 'https://media.valorant-api.com/agents/roles/1b47567f-8f7b-444b-aae3-b0c634622d10/displayicon.png',
                                fit: BoxFit.cover,
                              )),
                        ),
                        Text(
                          agentRole != 'Loading' ? agentRole : 'Initiator',
                          style: TextStyle(
                            height: 0.2,
                            fontFamily: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .fontFamily,
                            fontSize: 16,
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
