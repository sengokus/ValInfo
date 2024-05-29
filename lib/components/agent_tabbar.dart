import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AgentTab extends StatefulWidget {
  final Color? color;
  final Function(dynamic) onAgentSelected;

  const AgentTab({this.color, required this.onAgentSelected, super.key});

  @override
  AgentTabState createState() => AgentTabState();
}

class AgentTabState extends State<AgentTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(
        context); // Invoke the overridden method from AutomaticKeepAliveClientMixin

    return FutureBuilder(
      future: fetchAgents(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (final agent in snapshot.data!)
                    InkWell(
                      onTap: () {
                        widget.onAgentSelected(agent);
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
                      ),
                    ),
                ],
              ),
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

    // Filter out the duplicate Sova from the API
    final playableAgents =
        agents.where((agent) => agent['isPlayableCharacter'] == true).toList();

    return playableAgents;
  }
}
