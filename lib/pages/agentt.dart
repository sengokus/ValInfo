import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For storing favorites to local storage
import 'package:valinfo/components/agent_info_button.dart';
import 'package:valinfo/components/agent_tabbar.dart';
import 'agents_role.dart';
import 'specific_agent_info.dart';

class AgentInfoo extends StatefulWidget {
  final dynamic agent;

  const AgentInfoo({
    required this.agent,
    super.key,
  });

  @override
  AgentInfooState createState() => AgentInfooState();
}

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 40),
      child: const Icon(Icons.arrow_drop_down),
      onSelected: (String role) async {
        try {
          // Fetch agents with the selected role
          List<dynamic> agents = await fetchAgentsRole(role: role);
          log('Agents with role $role: ${agents.map((agent) => agent['displayName']).toList()}');

          // Push new page containing icons for agents
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AgentRolePage(agents: agents, role: role),
            ),
          );
        } catch (e) {
          throw ('Error: $e');
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem(value: 'Duelist', child: Text('Duelist')),
          const PopupMenuItem(value: 'Initiator', child: Text('Initiator')),
          const PopupMenuItem(value: 'Controller', child: Text('Controller')),
          const PopupMenuItem(value: 'Sentinel', child: Text('Sentinel')),
        ];
      },
    );
  }
}

class AgentInfooState extends State<AgentInfoo> {
  String? agentName;
  String? agentPhotoUrl;
  String? agentDescription;
  String? agentIcon;
  String? agentRoleName;
  String? agentRoleIcon;
  String? agentRoleDescription;
  String? agentBackground;

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
  }

  @override
  void dispose() {
    _pageController.dispose();
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
      agentBackground = agent['background'];

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

  // Add this method to your AgentInfooState class
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
    log("First background: $agentBackground");
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: 75,
          leading: const Padding(
            padding: EdgeInsets.only(left: 8.0), // Add padding to the left
            child: FilterButton(),
          ),
        ),
        body: FutureBuilder<void>(
            future: _dataFuture, // Initialize data before construction
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                ); // Show a loading spinner
              } else if (snapshot.hasError) {
                log("Error: ${snapshot.error}");
                return const Center(
                  child: Text('Error loading data'),
                ); // Handle errors
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
                    child: Stack(
                      children: [
                        Positioned(
                          top: 56,
                          left: 0,
                          right: 0,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: filteredAgents.length,
                            itemBuilder: (context, index) {
                              final item = filteredAgents[index];

                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AgentDetailsPage(
                                        agentName: item['displayName'],
                                        agentPhotoUrl: item['displayIcon'],
                                        agentDescription: '',
                                        agentRole: '',
                                        agentRoleIcon: '',
                                        agentRoleDescription: '',
                                        agentAbility1Name: '',
                                        agentAbility1Description: '',
                                        agentAbility1Icon: '',
                                        agentAbility2Name: '',
                                        agentAbility2Description: '',
                                        agentAbility2Icon: '',
                                        agentAbility3Name: '',
                                        agentAbility3Description: '',
                                        agentAbility3Icon: '',
                                        agentAbility4Name: '',
                                        agentAbility4Description: '',
                                        agentAbility4Icon: '',
                                      ),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  leading: Image.network(
                                    item['displayIcon'],
                                    fit: BoxFit.cover,
                                    width: 50,
                                    height: 50,
                                  ),
                                  title: Text(item['displayName']),
                                ),
                              );
                            },
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
                                      alignment: AlignmentDirectional.bottomEnd,
                                      children: [
                                        Positioned(
                                          right: 7,
                                          child: Image.network(
                                            agentBackground != null
                                                ? agentBackground ??
                                                    'Loading...'
                                                : 'https://media.valorant-api.com/agents/e370fa57-4757-3604-3648-499e1f642d3f/background.png',
                                            fit: BoxFit.fitHeight,
                                            height: 610,
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent?
                                                        loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return const SizedBox(
                                                height: 500,
                                              );
                                            },
                                          ),
                                        ),
                                        Positioned(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Hero(
                                              tag: 'agentPhoto',
                                              child: Image.network(
                                                agentPhotoUrl!,
                                                fit: BoxFit.fitHeight,
                                                height: 610,
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  }
                                                  return const SizedBox(
                                                    height: 500,
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 50,
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
                                                        ? const Icon(Icons.star,
                                                            color: Colors.white)
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
                                                          agentRoleIcon != null
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
                                      ],
                                    );
                                  }),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AgentInfoButton(
                                      onPressed: () {
                                        isFavorite[_currentPageIndex]
                                            ? log(
                                                "Removed agent ${agents[_currentPageIndex]['displayName']} to favorites.")
                                            : log(
                                                "Added agent ${agents[_currentPageIndex]['displayName']} from favorites.");
                                        addToFavorite({
                                          'index': _currentPageIndex,
                                          'agent': agents[_currentPageIndex],
                                        });
                                      },
                                      buttonText:
                                          isFavorite[_currentPageIndex]
                                              ? 'FAVORITED'
                                              : 'FAVORITE',
                                      backgroundColor:
                                          isFavorite[_currentPageIndex]
                                              ? Theme.of(context)
                                                  .indicatorColor
                                              : Theme.of(context).hoverColor,
                                    ),
                                    AgentInfoButton(
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
                                                  agentRoleName ?? 'Initiator',
                                              agentRoleIcon: agentRoleIcon ??
                                                  'https://media.valorant-api.com/agents/roles/1b47567f-8f7b-444b-aae3-b0c634622d10/displayicon.png',
                                              agentRoleDescription:
                                                  agentRoleDescription ??
                                                      'Initiators challenge angles by setting up their team to enter contested ground and push defenders away.',
                                              agentAbility1Name:
                                                  agentAbility1Name ??
                                                      'Wingman',
                                              agentAbility1Description:
                                                  agentAbility1Description ??
                                                      'EQUIP Wingman. FIRE to send Wingman forward seeking enemies. Wingman unleashes a concussive blast toward the first enemy he sees. ALT FIRE when targeting a Spike site or planted Spike to have Wingman defuse or plant the Spike. To plant, Gekko must have the Spike in his inventory. When Wingman expires he reverts into a dormant globule. INTERACT to reclaim the globule and gain another Wingman charge after a short cooldown.',
                                              agentAbility1Icon:
                                                  agentAbility1Icon ??
                                                      'https://media.valorant-api.com/agents/e370fa57-4757-3604-3648-499e1f642d3f/abilities/ability1/displayicon.png',
                                              agentAbility2Name:
                                                  agentAbility2Name ?? 'Dizzy',
                                              agentAbility2Description:
                                                  agentAbility2Description ??
                                                      'EQUIP Dizzy. FIRE to send Dizzy soaring forward through the air. Dizzy charges then unleashes plasma blasts at enemies in line of sight. Enemies hit by her plasma are Blinded. When Dizzy expires she reverts into a dormant globule. INTERACT to reclaim the globule and gain another Dizzy charge after a short cooldown.',
                                              agentAbility2Icon:
                                                  agentAbility2Icon ??
                                                      'https://media.valorant-api.com/agents/e370fa57-4757-3604-3648-499e1f642d3f/abilities/ability2/displayicon.png',
                                              agentAbility3Name:
                                                  agentAbility3Name ??
                                                      'Mosh Pit',
                                              agentAbility3Description:
                                                  agentAbility3Description ??
                                                      'EQUIP Mosh. FIRE to throw Mosh like a grenade. ALT FIRE to lob. Upon landing Mosh duplicates across a large area that deals a small amount of damage over time then after a short delay explodes.',
                                              agentAbility3Icon:
                                                  agentAbility3Icon ??
                                                      'https://media.valorant-api.com/agents/e370fa57-4757-3604-3648-499e1f642d3f/abilities/grenade/displayicon.png',
                                              agentAbility4Name:
                                                  agentAbility4Name ?? 'Thrash',
                                              agentAbility4Description:
                                                  agentAbility4Description ??
                                                      'EQUIP Thrash. FIRE to link with Thrash’s mind and steer her through enemy territory. ACTIVATE to lunge forward and explode, Detaining any players in a small radius. When Thrash expires she reverts into a dormant globule. INTERACT to reclaim the globule and gain another Thrash charge after a short cooldown. Thrash can be reclaimed once.',
                                              agentAbility4Icon:
                                                  agentAbility4Icon ??
                                                      'https://media.valorant-api.com/agents/e370fa57-4757-3604-3648-499e1f642d3f/abilities/ultimate/displayicon.png',
                                            ),
                                          ),
                                        );
                                      },
                                      backgroundColor:
                                          Theme.of(context).hoverColor,
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ],
                    ));
              }
            }));
  }
}
