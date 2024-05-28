import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:valinfo/pages/agent_info.dart';

class AgentTab extends StatelessWidget {
  final Color? color;

  const AgentTab({this.color, super.key});

  @override
  Widget build(BuildContext context) {
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
                  // Create icons for each agent
                  for (final agent in snapshot.data!)
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                AgentInfo(agent: agent),
                            // Remove zoom animation
                            transitionDuration: const Duration(seconds: 0),
                          ),
                        );
                      },
                      child: Container(
                        width: 60,
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          color: color,
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
