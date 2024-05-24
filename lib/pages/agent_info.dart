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

  @override
  void initState() {
    super.initState();
    fetchAgentData(widget.agent);
  }

  // Function to fetch agent data
  Future<void> fetchAgentData(dynamic agent) async {
    setState(() {
      agentName = agent['displayName'];
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
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.network(
                      agentPhotoUrl!,
                    ),
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
                        agentInfoButton(
                          buttonText: "FAVORITE",
                          onPressed: () {
                            // ADD FAVORITE HERE
                          },
                        ),
                        const SizedBox(width: 5),
                        agentInfoButton(
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
