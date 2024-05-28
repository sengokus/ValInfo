import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../pages/agent_info.dart';

Widget agentTab() {
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
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => AgentInfo(agent: agent),
                          transitionDuration: const Duration(seconds: 0), // Remove zoom animation
                        ),
                      );
                    },
                    child: Container(
                      width: 45,
                      margin: const EdgeInsets.symmetric(horizontal: 1.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
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
  final response = await http.get(Uri.parse('https://valorant-api.com/v1/agents'));
  final data = jsonDecode(response.body);
  final List<dynamic> agents = data['data'];
  
  // Filter out the duplicate Sova from the API
  final playableAgents = agents.where((agent) => agent['isPlayableCharacter'] == true).toList();

  return playableAgents;
}