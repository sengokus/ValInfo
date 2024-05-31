import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:valinfo/pages/specific_agent_info.dart';

class SearchResultsPage extends StatefulWidget {
  final String searchQuery;

  const SearchResultsPage({required this.searchQuery, Key? key}) : super(key: key);

  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  late Future<List<dynamic>> searchResultsFuture;

  @override
  void initState() {
    super.initState();
    searchResultsFuture = fetchSearchResults();
  }

 Future<List<dynamic>> fetchSearchResults() async {
  final response = await http.get(Uri.parse('https://valorant-api.com/v1/agents'));

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON
    Map<String, dynamic> responseData = json.decode(response.body);

    // Extract the list of agents from the response
    List<dynamic> agents = responseData['data'] ?? [];

    // Filter agents based on the matching name (case-insensitive)
    List<dynamic> matchingAgents = agents.where((agent) => 
      agent['displayName'].toString().toLowerCase() == widget.searchQuery.toLowerCase()
    ).toList();

    return matchingAgents;
  } else {
    // If the server did not return a 200 OK response, throw an exception
    throw Exception('Failed to load search results');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Search Results for: ${widget.searchQuery}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: searchResultsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<dynamic> searchResults = snapshot.data ?? [];

                  return GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      var agent = searchResults[index];
                      String agentFace = agent['displayIcon'];
                      String agentPhotoUrl = agent['fullPortrait'];

                      // Extracting agent data
                      final agentName = agent['displayName'] ?? '';
                      final agentDescription = agent['description'] ?? '';
                      final agentRoleIcon = agent['role']['displayIcon'] ?? '';
                      final agentRoleName = agent['role']['displayName'] ?? '';
                      final agentAbility1Name = agent['abilities'][0]['displayName'] ?? '';
                      final agentAbility1Icon = agent['abilities'][0]['displayIcon'] ?? '';
                      final agentAbility1Description = agent['abilities'][0]['description'] ?? '';
                      final agentAbility2Name = agent['abilities'][1]['displayName'] ?? '';
                      final agentAbility2Icon = agent['abilities'][1]['displayIcon'] ?? '';
                      final agentAbility2Description = agent['abilities'][1]['description'] ?? '';
                      final agentAbility3Name = agent['abilities'][2]['displayName'] ?? '';
                      final agentAbility3Icon = agent['abilities'][2]['displayIcon'] ?? '';
                      final agentAbility3Description = agent['abilities'][2]['description'] ?? '';
                      final agentAbility4Name = agent['abilities'][3]['displayName'] ?? '';
                      final agentAbility4Icon = agent['abilities'][3]['displayIcon'] ?? '';
                      final agentAbility4Description = agent['abilities'][3]['description'] ?? '';

                      return GestureDetector(
                        onTap: () {
                          // Navigate to AgentDetailsPage when the card is tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AgentDetailsPage(
                                agentName: agentName,
                                agentPhotoUrl: agentPhotoUrl,
                                agentDescription: agentDescription,
                                agentRole: agentRoleName,
                                agentRoleIcon: agentRoleIcon,
                                agentAbility1Name: agentAbility1Name,
                                agentAbility1Icon: agentAbility1Icon,
                                agentAbility1Description: agentAbility1Description,
                                agentAbility2Name: agentAbility2Name,
                                agentAbility2Icon: agentAbility2Icon,
                                agentAbility2Description: agentAbility2Description,
                                agentAbility3Name: agentAbility3Name,
                                agentAbility3Icon: agentAbility3Icon,
                                agentAbility3Description: agentAbility3Description,
                                agentAbility4Name: agentAbility4Name,
                                agentAbility4Icon: agentAbility4Icon,
                                agentAbility4Description: agentAbility4Description,
                                agentRoleDescription: '', // You might want to fetch this data separately
                              ),
                            ),
                          );
                        },
                        child: Card(
                          child: Image.network(agentFace, fit: BoxFit.cover),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
