import 'dart:developer';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Unofficial Valorant API from valorant-api.com
Future<Map<String, dynamic>> fetchValApiData() async {
  const String agentsUrl = 'https://valorant-api.com/v1/agents';

  // Fetching agents data
  final agentResponse = await http.get(Uri.parse(agentsUrl));

  if (agentResponse.statusCode == 200) {
    final Map<String, dynamic> agentsData = json.decode(agentResponse.body);
    final List<dynamic> agents = agentsData['data'];

    log("Got: ${agentsData['displayName']}");
    log("Got: ${agents[0]}");

    //
    final agent = agents[0];
    return {
      'displayName': agent['displayName'],
      'fullPortrait': agent['fullPortrait'],
      'description': agent['description'],
      'agentIcon': agent['displayIcon'],
      'agentRoleName': agent['role']['displayName'],
      'agentRoleIcon': agent['role']['displayIcon'],
      'agentRoleDescription': agent['role']['description'],
    };
  } else {
    throw Exception('Failed to fetch agents data: ${agentResponse.statusCode}');
  }
}
