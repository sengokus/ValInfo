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
  _AgentInfoState createState() => _AgentInfoState();
}

class _AgentInfoState extends State<AgentInfo> {
  String? agentName;
  String? agentPhotoUrl;
  String? agentDescription;
  String? agentIcon;
  // String? agentType;
  String? agentRoleName;
  String? agentRoleIcon;
  //List<String>? agentAbilities;

  bool isPressedFavorite = false;

  @override
  void initState() {
    super.initState();
    fetchAgentData(widget.agent);
  }
  
  // Function to fetch agent data
  Future<void> fetchAgentData(dynamic agent) async {
    setState(() {
      agentName = agent['displayName'];
      // agentType = agent.role['displayName'];
      agentPhotoUrl = agent['fullPortrait'];
      agentDescription = agent['description'];
      agentRoleName = agent['role'] != null ? agent['role']['displayName'] : null;
      agentRoleIcon = agent['role'] != null ? agent['role']['displayIcon'] : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Agent Info'),
      // ),
      body: Center(
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
                      agentName ?? 'Loading...',
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
                    height: 500, loadingBuilder: (BuildContext context,
                        Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  // Return a SizedBox of the same height as the image while it is loading
                  return const SizedBox(height: 500);
                }),
              ),
            ],
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8),
          //   child: Container(
          //     color: Colors.black,
          //     child: Image.network(
          //       agentIcon!,
          //       height: 50,
          //       width: 50,
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                AgentInfoButton(
                  onPressed: () {
                    // ADD FAVORITE HERE
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
                            agentRole: agentRoleName ?? 'Loading'
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          agentTab(),
        ],
      )),
    );
  }
}
