import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:valinfo/components/agent_info_button.dart';
import 'package:valinfo/components/agent_tabbar.dart';
import 'specific_agent_info.dart';

class AgentInfo extends StatefulWidget {
  final dynamic agent;

  const AgentInfo({
    required this.agent,
    super.key,
  });

  @override
  AgentInfoState createState() => AgentInfoState();
}

class AgentInfoState extends State<AgentInfo> {
  String? agentName;
  String? agentPhotoUrl;
  String? agentDescription;
  String? agentIcon;

  String? agentRoleName;
  String? agentRoleIcon;
  String? agentRoleDescription;

  bool isPressedFavorite = false;

  @override
  void initState() {
    super.initState();
    fetchAgentData(widget.agent);
  }

  // Function to fetch agent data
  void fetchAgentData(dynamic agent) {
    log("Fetching data for: ${agent['displayName']} : ${agent['role'] != null ? agent['role']['displayName'] : null}");

    setState(() {
      agentName = agent['displayName'];
      agentPhotoUrl = agent['fullPortrait'];
      agentDescription = agent['description'];
      agentRoleName =
          agent['role'] != null ? agent['role']['displayName'] : null;
      agentRoleIcon =
          agent['role'] != null ? agent['role']['displayIcon'] : null;
      agentRoleDescription =
          agent['role'] != null ? agent['role']['description'] : null;
    });
  }

  void updateSelectedAgent(dynamic agent) {
    setState(() {
      agentName = agent['displayName'];
      agentPhotoUrl = agent['fullPortrait'];
      agentDescription = agent['description'];
      agentRoleName =
          agent['role'] != null ? agent['role']['displayName'] : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [Color(0xff3e606c), Color(0xff4c7a8a), Color(0xff222042)],
        stops: [0, 0.12, 1],
        begin: Alignment(-0.4, -1.0),
        end: Alignment(1.9, 2.3),
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              Positioned(
                top: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      agentName ?? 'Loading...',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.titleMedium!.color,
                        fontFamily:
                            Theme.of(context).textTheme.titleMedium!.fontFamily,
                        fontSize:
                            Theme.of(context).textTheme.titleMedium!.fontSize,
                      ),
                    ),
                    Text(
                      agentRoleName ?? 'Loading...',
                      style: TextStyle(
                        fontFamily:
                            Theme.of(context).textTheme.titleSmall!.fontFamily,
                        fontSize:
                            Theme.of(context).textTheme.titleSmall!.fontSize,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Image.network(agentPhotoUrl!,
                    fit: BoxFit.fitHeight,
                    height: 610, loadingBuilder: (BuildContext context,
                        Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return const SizedBox(height: 500);
                }),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                AgentInfoButton(
                  onPressed: () {
                    setState(() {
                      isPressedFavorite = !isPressedFavorite;
                    });
                  },
                  buttonText: isPressedFavorite ? "FAVORITED" : "FAVORITE",
                  backgroundColor: isPressedFavorite
                      ? Theme.of(context).indicatorColor
                      : null,
                ),
                const SizedBox(width: 5),
                AgentInfoButton(
                  buttonText: "VIEW CONTRACT",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AgentDetailsPage(
                          agentName: agentName!,
                          agentPhotoUrl: agentPhotoUrl!,
                          agentDescription: agentDescription!,
                          agentRole: agentRoleName ?? 'Loading',
                          agentRoleIcon: agentRoleIcon ?? 'Loading',
                          agentRoleDescription:
                              agentRoleDescription ?? 'Loading',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          AgentTab(
            color: Theme.of(context).indicatorColor,
            onAgentSelected: updateSelectedAgent,
          ),
        ],
      ),
    ));
  }
}
