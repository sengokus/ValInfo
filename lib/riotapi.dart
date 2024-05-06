import 'dart:convert';
import 'package:http/http.dart' as http;

// Unofficial Valorant API from valorant-api.com 
Future<Map<String, dynamic>> fetchValApiData() async {
  const String apiKey = '9EDBB66DDAF03A61'; // Replace with your API key
  const String agentsUrl = 'https://valorant-api.com/v1/agents';

  // Fetching agents data
  final agentResponse =
      await http.get(Uri.parse(agentsUrl), headers: {'X-Riot-Token': apiKey});

  if (agentResponse.statusCode == 200) {
    final Map<String, dynamic> agentsData = json.decode(agentResponse.body);
    final List<dynamic> agents = agentsData['data'];

    // LAST AGENT IS AT INDEX 24
    final agent = agents[23];
    return {
      'displayName': agent['displayName'],
      'fullPortrait': agent['fullPortrait'],
      'description': agent['description'],
    };
  } else {
    throw Exception('Failed to fetch agents data: ${agentResponse.statusCode}');
  }
}


/*
// Valorant API from valorant-api.com
Future<void> fetchValApiData() async {
  const String apiKey = '9EDBB66DDAF03A61'; // Replace with your API key
  const String agentsUrl = 'https://valorant-api.com/v1/agents';
  const String mapsUrl = 'https://valorant-api.com/v1/maps';

  // Fetching agents data
  final agentResponse = await http.get(Uri.parse(agentsUrl), headers: {'X-Riot-Token': apiKey});

  if (agentResponse.statusCode == 200) {
    final Map<String, dynamic> agentsData = json.decode(agentResponse.body);
    final List<dynamic> agents = agentsData['data'];
    for (var agent in agents) {
      print('Agent: ${agent['displayName']}\n  Description: ${agent['description']}\n');
    }
  } else {
    print('Failed to fetch agents data: ${agentResponse.statusCode}');
  }

  // Fetching maps data
  final mapResponse = await http.get(Uri.parse(mapsUrl), headers: {'X-Riot-Token': apiKey});

  if (mapResponse.statusCode == 200) {
    final Map<String, dynamic> mapsData = json.decode(mapResponse.body);
    final List<dynamic> maps = mapsData['data'];
    for (var map in maps) {
      print('Map: ${map['displayName']}');
    }
  } else {
    print('Failed to fetch maps data: ${mapResponse.statusCode}');
  }
}

*/

/*

// Official RIOT Valorant API 

Future<void> fetchValData() async {
  const String apiKey = 'RGAPI-0c9993e7-c964-471a-9294-344af5b1b3b6'; // CHANGE API KEY. Expires within 24 hours 
  const String url = 'https://ap.api.riotgames.com/val/content/v1/contents?locale=en-US&api_key=$apiKey';

  // Making the HTTP GET request
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    
    // Temporary. Can retrieve AGENTS, MAPS
    final List<dynamic> agents = data['characters'];
    for (var agent in agents) {
      print('Agents: ${agent['name']}'); 
    }

    final List<dynamic> maps = data['maps'];
    for (var map in maps) {
      print('Maps: ${map['name']}');  
    }
  }
}

*/