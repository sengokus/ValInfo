import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;


 class AgentTab extends StatefulWidget {
  final Color? color;
  final Function(Map<String, dynamic>) onAgentSelected;
  final int currentIndex; // Added currentIndex
  final List<dynamic> agents; // Pass agents to the AgentTab

  const AgentTab({
    this.color,
    required this.onAgentSelected,
    required this.currentIndex,
    required this.agents,
    super.key,
  });

  @override
  AgentTabState createState() => AgentTabState();
}

class AgentTabState extends State<AgentTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final agents = fetchAgents();

    return FutureBuilder<List<dynamic>>(
      future: agents,
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return CarouselSlider(
              options: CarouselOptions(
                height: 60,
                aspectRatio: 1.0,
                viewportFraction: 0.2,
                enableInfiniteScroll: true,
              ),
              items: snapshot.data!.asMap().entries.map<Widget>((entry) {
                int index = entry.key;
                var agent = entry.value;
                return InkWell(
                    onTap: () {
                      widget.onAgentSelected({'index': index, 'agent': agent});
                    },
                    child: Container(
                      width: 60,
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        color: widget.color,
                        border: Border.all(
                          color: Colors.white30,
                          width: 1,
                        ),
                      ),
                      child: Image.network(
                        agent['displayIcon'],
                        fit: BoxFit.cover,
                      ),
                    ));
              }).toList(),
            );
          }
        }
      },
    );
  }




  Future<List<dynamic>> fetchAgents() async {
    final response =
        await http.get(Uri.parse('https://valorant-api.com/v1/agents'));
    final data = jsonDecode(response.body);
    final List<dynamic> agents = data['data'];

    final playableAgents =
        agents.where((agent) => agent['isPlayableCharacter'] == true).toList();

    return playableAgents;
  }
}


//fetch agents based on their role
Future<List<dynamic>> fetchAgentsRole({String? role}) async {
  final response = await http.get(Uri.parse('https://valorant-api.com/v1/agents'));
  if (response.statusCode != 200) {
    throw Exception('Failed to fetch agents data');
  }

  final data = jsonDecode(response.body);
  final List<dynamic> agents = data['data'];

  // Filter agents who are playable characters
  final playableAgents = agents.where((agent) => agent['isPlayableCharacter'] == true).toList();

  // If role is specified, filter by role
  if (role != null && role.isNotEmpty) {
    return playableAgents.where((agent) => agent['role'] != null && agent['role']['displayName'] == role).toList();
  }

  return playableAgents;
}



