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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Agent Info'),
      // ),
      body: Center(
        child: agentPhotoUrl != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Positioned(
                        top: 50,
                        child: Column(
                          children: [
                            Text(
                              agentName ?? 'Loading...',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .color,
                                fontFamily: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .fontFamily,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .fontSize,
                              ),
                            ),
                            Text(
                              agentName ?? 'Loading...',
                              style: TextStyle(
                                fontFamily: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .fontFamily,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .fontSize,
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
                                Widget child,
                                ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Color.fromARGB(255, 250, 68, 84),
                            ),
                          );
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
                          buttonText: "FAVORITE",
                          onPressed: () {
                            // ADD FAVORITE HERE
                            setState(() {
                              isPressedFavorite = !isPressedFavorite;
                            });
                          },
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
              )
            : const CircularProgressIndicator(
                color: Color.fromARGB(255, 250, 68, 84),
              ),
      ),
    );
  }
}
