import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For storing favorites to local storage
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
  AgentInfoState createState() => AgentInfoState();
}

class AgentInfoState extends State<AgentInfo> {
  String? agentName;
  String? agentPhotoUrl;
  String? agentDescription;
  String? agentIcon;
  String? agentRoleName;
  String? agentRoleIcon;
  String? agentRoleDescription;

  String? agentAbility1Name;
  String? agentAbility1Icon;
  String? agentAbility1Description;

  String? agentAbility2Name;
  String? agentAbility2Icon;
  String? agentAbility2Description;

  String? agentAbility3Name;
  String? agentAbility3Icon;
  String? agentAbility3Description;

  String? agentAbility4Name;
  String? agentAbility4Icon;
  String? agentAbility4Description;

  late Future<void> _dataFuture;

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _showSuggestions = false;
  bool _isSearchOpen = false;

  late PageController _pageController;
  int _currentPageIndex = 0;
  List<dynamic> agents = []; // Store the agents list
  List<dynamic> filteredAgents = [];
  List<bool> isFavorite = []; // Store favorites in list

  bool isPressedFavorite = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _dataFuture = initData();
    _searchController.addListener(() {
      searchAgent(_searchController.text);
    });
    _searchFocusNode.addListener(() {
      setState(() {
        _showSuggestions = _searchFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // Future to initialize data
  Future<void> initData() async {
    await fetchAgents(); // Fetch agents list
    await loadFavorites(); // Fetch favorites list
    await fetchAgentData(widget.agent);
  }

  // Function to fetch agent data
  Future<void> fetchAgentData(dynamic agent) async {
    log("Fetching data for not: ${agent['displayName']} : ${agent['abilities'] != null ? agent['abilities'][3]['displayName'] : null}");

    setState(() {
      agentName = agent['displayName'];
      agentPhotoUrl = agent['fullPortrait'];
      agentDescription = agent['description'];
      agentRoleName =
          agent['role'] != null ? agent['role']['displayName'] : null;
      agentRoleIcon =
          agent['role'] != null ? agent['role']['displayIcon'] : null;
      agentRoleDescription =
          agent['role'] != null ? agent['role']['description'] : null;

      agentAbility1Name = agent['abilities'] != null
          ? agent['abilities'][0]['displayName']
          : null;
      agentAbility1Icon = agent['abilities'] != null
          ? agent['abilities'][0]['displayIcon']
          : null;
      agentAbility1Description = agent['abilities'] != null
          ? agent['abilities'][0]['description']
          : null;

      agentAbility2Name = agent['abilities'] != null
          ? agent['abilities'][1]['displayName']
          : null;
      agentAbility2Icon = agent['abilities'] != null
          ? agent['abilities'][1]['displayIcon']
          : null;
      agentAbility2Description = agent['abilities'] != null
          ? agent['abilities'][1]['description']
          : null;

      agentAbility3Name = agent['abilities'] != null
          ? agent['abilities'][2]['displayName']
          : null;
      agentAbility3Icon = agent['abilities'] != null
          ? agent['abilities'][2]['displayIcon']
          : null;
      agentAbility3Description = agent['abilities'] != null
          ? agent['abilities'][2]['description']
          : null;

      agentAbility4Name = agent['abilities'] != null
          ? agent['abilities'][3]['displayName']
          : null;
      agentAbility4Icon = agent['abilities'] != null
          ? agent['abilities'][3]['displayIcon']
          : null;
      agentAbility4Description = agent['abilities'] != null
          ? agent['abilities'][3]['description']
          : null;
    });
  }

  // Fetch the list of agents
  Future<void> fetchAgents() async {
    final response =
        await http.get(Uri.parse('https://valorant-api.com/v1/agents'));
    final data = jsonDecode(response.body);
    final List<dynamic> agentsList = data['data'];

    setState(() {
      agents =
          agentsList.where((agent) => agent['isPlayableCharacter']).toList();
      isFavorite =
          List<bool>.filled(agents.length, false); // Initialize isFavorite list
    });
  }

  // Load favorites from local storage
  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteList = prefs.getStringList('favorites') ?? [];
    setState(() {
      isFavorite =
          agents.map((agent) => favoriteList.contains(agent['uuid'])).toList();
    });
  }

  // Update screen based on selected agent
  void updateSelectedAgent(Map<String, dynamic> selectedAgent) {
    setState(() {
      _currentPageIndex = selectedAgent['index'];
      fetchAgentData(selectedAgent['agent']);
      _pageController.jumpToPage(_currentPageIndex);
    });
  }

  // Add agent to favorites
  void addToFavorite(Map<String, dynamic> selectedAgent) async {
    setState(() {
      isFavorite[selectedAgent['index']] = !isFavorite[selectedAgent['index']];
    });

    final prefs = await SharedPreferences.getInstance();
    final favoriteList = isFavorite
        .asMap()
        .entries
        .where((entry) => entry.value)
        .map((entry) => agents[entry.key]['uuid'] as String)
        .toList();
    prefs.setStringList('favorites', favoriteList);
  }

  // Add this method to your AgentInfoState class
  void removeFromFavorites(int index) {
    setState(() {
      isFavorite[index] = false;
    });
  }

  void searchAgent(String query) {
    final suggestions = agents.where((agent) {
      final agentList = agent['displayName'].toLowerCase();
      final input = query.toLowerCase();

      return agentList.contains(input);
    }).toList();

    setState(() => filteredAgents = suggestions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(_isSearchOpen ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearchOpen = !_isSearchOpen;
                if (!_isSearchOpen) {
                  _searchController.clear();
                  _showSuggestions = false;
                }
              });
            },
          ),
          title: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            width: _isSearchOpen ? MediaQuery.of(context).size.width : 0,
            child: _isSearchOpen
                ? TextField(
                    style: TextStyle(
                      fontFamily:
                          Theme.of(context).textTheme.titleSmall!.fontFamily,
                      fontSize:
                          Theme.of(context).textTheme.titleSmall!.fontSize,
                    ),
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    decoration: const InputDecoration(
                      hintText: 'Search agents',
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.transparent,
                    ),
                  )
                : null,
          ),
        ),
        body: FutureBuilder<void>(
            future: _dataFuture, // Initialize data before construction
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child:
                        CircularProgressIndicator()); // Show a loading spinner
              } else if (snapshot.hasError) {
                log("Error: ${snapshot.error}");
                return const Center(
                    child: Text('Error loading data')); // Handle errors
              } else {
                return Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff3e606c),
                          Color(0xff4c7a8a),
                          Color(0xff222042)
                        ],
                        stops: [0, 0.12, 1],
                        begin: Alignment(-0.4, -1.0),
                        end: Alignment(1.9, 2.3),
                      ),
                    ),
                    child: Stack(children: [
                      if (_showSuggestions && _searchController.text.isNotEmpty)
                        Positioned(
                          top: 56,
                          left: 0,
                          right: 0,
                          child: Container(
                            color: Colors.white,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: filteredAgents.length,
                              itemBuilder: (context, index) {
                                final item = filteredAgents[index];
                                return ListTile(
                                  leading: Image.network(item['displayIcon'],
                                      fit: BoxFit.cover, width: 50, height: 50),
                                  title: Text(item['displayName']),
                                  onTap: () {
                                    _searchController.text =
                                        item['displayName'];
                                    setState(() {
                                      _showSuggestions = false;
                                    });
                                    fetchAgentData(item);
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: PageView.builder(
                                    controller: _pageController,
                                    itemCount: agents
                                        .length, // Use the agents list count
                                    onPageChanged: (index) {
                                      setState(() {
                                        _currentPageIndex = index;
                                        fetchAgentData(agents[index]);
                                      });
                                    },
                                    itemBuilder: (context, index) {
                                      return Stack(
                                        alignment:
                                            AlignmentDirectional.bottomEnd,
                                        children: [
                                          Positioned(
                                            top: 20,
                                            right: 20,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8.0),
                                                      child: isFavorite[
                                                              _currentPageIndex]
                                                          ? const Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.white)
                                                          : Icon(
                                                              Icons
                                                                  .star_border_outlined,
                                                              color: Theme.of(
                                                                      context)
                                                                  .indicatorColor),
                                                    ),
                                                    Text(
                                                      agentName ?? 'Loading...',
                                                      style: TextStyle(
                                                        height: 1.0,
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium!
                                                            .color,
                                                        fontFamily:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .titleMedium!
                                                                .fontFamily,
                                                        fontSize:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .titleMedium!
                                                                .fontSize,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8.0),
                                                      child: SizedBox(
                                                          width: 12,
                                                          height: 12,
                                                          child: Image.network(
                                                            agentRoleIcon !=
                                                                    null
                                                                ? agentRoleIcon ??
                                                                    'Loading...'
                                                                : 'https://media.valorant-api.com/agents/roles/1b47567f-8f7b-444b-aae3-b0c634622d10/displayicon.png',
                                                            fit: BoxFit.cover,
                                                          )),
                                                    ),
                                                    Text(
                                                      agentRoleName != null
                                                          ? agentRoleName ??
                                                              'Loading...'
                                                          : 'Initiator',
                                                      style: TextStyle(
                                                        height: 0.2,
                                                        fontFamily:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .titleSmall!
                                                                .fontFamily,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Image.network(agentPhotoUrl!,
                                                fit: BoxFit.fitHeight,
                                                height: 610, loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return const SizedBox(
                                                  height: 500);
                                            }),
                                          ),
                                        ],
                                      );
                                    })),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: AgentInfoButton(
                                          onPressed: () {
                                            isFavorite[_currentPageIndex]
                                                ? log(
                                                    "Removed agent ${agents[_currentPageIndex]['displayName']} to favorites.")
                                                : log(
                                                    "Added agent ${agents[_currentPageIndex]['displayName']} from favorites.");
                                            addToFavorite({
                                              'index': _currentPageIndex,
                                              'agent':
                                                  agents[_currentPageIndex],
                                            });
                                          },
                                          buttonText:
                                              isFavorite[_currentPageIndex]
                                                  ? 'FAVORITED'
                                                  : 'FAVORITE',
                                          backgroundColor: isFavorite[
                                                  _currentPageIndex]
                                              ? Theme.of(context).indicatorColor
                                              : Theme.of(context).hoverColor,
                                        )),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: AgentInfoButton(
                                        buttonText: 'VIEW CONTRACT',
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AgentDetailsPage(
                                                agentName: agentName!,
                                                agentPhotoUrl: agentPhotoUrl!,
                                                agentDescription:
                                                    agentDescription!,
                                                agentRole:
                                                    agentRoleName ?? 'Loading',
                                                agentRoleIcon:
                                                    agentRoleIcon ?? 'Loading',
                                                agentRoleDescription:
                                                    agentRoleDescription ??
                                                        'Loading',
                                                agentAbility1Name:
                                                    agentAbility1Name ??
                                                        'Loading',
                                                agentAbility1Description:
                                                    agentAbility1Description ??
                                                        'Loading',
                                                agentAbility1Icon:
                                                    agentAbility1Icon ??
                                                        'Loading',
                                                agentAbility2Name:
                                                    agentAbility2Name ??
                                                        'Loading',
                                                agentAbility2Description:
                                                    agentAbility2Description ??
                                                        'Loading',
                                                agentAbility2Icon:
                                                    agentAbility2Icon ??
                                                        'Loading',
                                                agentAbility3Name:
                                                    agentAbility3Name ??
                                                        'Loading',
                                                agentAbility3Description:
                                                    agentAbility3Description ??
                                                        'Loading',
                                                agentAbility3Icon:
                                                    agentAbility3Icon ??
                                                        'Loading',
                                                agentAbility4Name:
                                                    agentAbility4Name ??
                                                        'Loading',
                                                agentAbility4Description:
                                                    agentAbility4Description ??
                                                        'Loading',
                                                agentAbility4Icon:
                                                    agentAbility4Icon ??
                                                        'Loading',
                                              ),
                                            ),
                                          );
                                        },
                                        backgroundColor:
                                            Theme.of(context).hoverColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: AgentTab(
                                color: Theme.of(context).hoverColor,
                                onAgentSelected: updateSelectedAgent,
                                currentIndex:
                                    _currentPageIndex, // Pass the current index
                                agents: agents, // Pass the agents list
                              ),
                            ),
                          ])
                    ]));
              }
            }));
  }
}
