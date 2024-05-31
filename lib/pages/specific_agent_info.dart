import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:valinfo/components/agent_abilities_tabbar.dart';
import 'package:valinfo/components/agent_info_box.dart';

class AgentDetailsPage extends StatefulWidget {
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
  });

  @override
  _AgentDetailsPageState createState() => _AgentDetailsPageState();
}

class _AgentDetailsPageState extends State<AgentDetailsPage> {
  late String currentAgentRole;
  late String currentAgentRoleDescription;

  @override
  void initState() {
    super.initState();
    currentAgentRole = widget.agentRole;
    currentAgentRoleDescription = widget.agentRoleDescription;
  }

  void _updateAgentRole(String roleName, String roleDescription) {
    setState(() {
      currentAgentRole = roleName;
      currentAgentRoleDescription = roleDescription;
    });
  }

  @override
  Widget build(BuildContext context) {
    log("Role: ${widget.agentRole} : ${widget.agentRoleIcon}");

    return Scaffold(
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
        child: Stack(children: [
          Stack(
            children: [
              Image.network(
                widget.agentPhotoUrl,
                fit: BoxFit.fitHeight,
                height: 800,
              ),
              Positioned(
                bottom: 50,
                left: 0,
                right: 0,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: InfoCard(
                    agentDescription: widget.agentDescription,
                    agentRole: currentAgentRole,
                    agentRoleDescription: currentAgentRoleDescription,
                  ),
                ),
              ),
              Positioned(
                top: 50,
                right: 20,
                child: Column(
                  children: [
                    Text(
                      widget.agentName,
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
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: SizedBox(
                              width: 12,
                              height: 12,
                              child: Image.network(
                                widget.agentRoleIcon != 'Loading'
                                    ? widget.agentRoleIcon
                                    : 'https://media.valorant-api.com/agents/roles/1b47567f-8f7b-444b-aae3-b0c634622d10/displayicon.png',
                                fit: BoxFit.cover,
                              )),
                        ),
                        Text(
                          widget.agentRole != 'Loading'
                              ? widget.agentRole
                              : 'Initiator',
                          style: TextStyle(
                            height: 0.2,
                            fontFamily: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .fontFamily,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 50,
                left: 20,
                child: AgentAbilities(
                  abilities: [
                    {
                      'name': widget.agentAbility1Name,
                      'description': widget.agentAbility1Description,
                      'icon': widget.agentAbility1Icon,
                    },
                    {
                      'name': widget.agentAbility2Name,
                      'description': widget.agentAbility2Description,
                      'icon': widget.agentAbility2Icon,
                    },
                    {
                      'name': widget.agentAbility3Name,
                      'description': widget.agentAbility3Description,
                      'icon': widget.agentAbility3Icon,
                    },
                    {
                      'name': widget.agentAbility4Name,
                      'description': widget.agentAbility4Description,
                      'icon': widget.agentAbility4Icon,
                    },
                  ],
                  onAbilityClicked: _updateAgentRole,
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
