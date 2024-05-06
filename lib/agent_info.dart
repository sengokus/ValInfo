import 'package:flutter/material.dart';
import 'riotapi.dart';

class AgentInfo extends StatefulWidget {
  const AgentInfo({super.key});

  @override
  _AgentInfoState createState() => _AgentInfoState();
}

class _AgentInfoState extends State<AgentInfo> {
  String? agentName;
  String? agentPhotoUrl;
  String? agentDescription;

  // Function to fetch agent data
  Future<void> fetchAgentData() async {
    final agentData = await fetchValApiData();
    setState(() {
      agentName = agentData['displayName'];
      agentPhotoUrl = agentData['fullPortrait'];
      agentDescription = agentData['description'];
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAgentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agent Info'),
      ),
      body: Center(
        child: agentPhotoUrl != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    agentName ?? 'Loading...',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.network(
                      agentPhotoUrl!,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      agentDescription ?? 'Loading...',
                      style: const TextStyle(fontSize: 15, height: 1.5,),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
