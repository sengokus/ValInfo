// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:valinfo/components/agent_info_button.dart';
// import 'package:valinfo/components/agent_tabbar.dart';
// import 'specific_agent_info.dart';

// class AgentInfo extends StatefulWidget {
//   final dynamic agent;

//   const AgentInfo({
//     required this.agent,
//     super.key,
//   });

//   @override
//   AgentInfoState createState() => AgentInfoState();
// }

// class AgentInfoState extends State<AgentInfo> {
//   String? agentName;
//   String? agentPhotoUrl;
//   String? agentDescription;
//   String? agentIcon;

//   String? agentRoleName;
//   String? agentRoleIcon;
//   String? agentRoleDescription;

//   bool isPressedFavorite = false;

//   @override
//   void initState() {
//     super.initState();
//     fetchAgentData(widget.agent);
//   }

//   // Function to fetch agent data
//   void fetchAgentData(dynamic agent) {
//     log("Fetching data for: ${agent['displayName']} : ${agent['role'] != null ? agent['role']['displayName'] : null}");

//     setState(() {
//       agentName = agent['displayName'];
//       agentPhotoUrl = agent['fullPortrait'];
//       agentDescription = agent['description'];
//       agentRoleName =
//           agent['role'] != null ? agent['role']['displayName'] : null;
//       agentRoleIcon =
//           agent['role'] != null ? agent['role']['displayIcon'] : null;
//       agentRoleDescription =
//           agent['role'] != null ? agent['role']['description'] : null;
//     });
//   }

//   void updateSelectedAgent(dynamic agent) {
//     setState(() {
//       agentName = agent['displayName'];
//       agentPhotoUrl = agent['fullPortrait'];
//       agentDescription = agent['description'];
//       agentRoleName =
//           agent['role'] != null ? agent['role']['displayName'] : null;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//       decoration: const BoxDecoration(
//           gradient: LinearGradient(
//         colors: [Color(0xff3e606c), Color(0xff4c7a8a), Color(0xff222042)],
//         stops: [0, 0.12, 1],
//         begin: Alignment(-0.4, -1.0),
//         end: Alignment(1.9, 2.3),
//       )),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Stack(
//             clipBehavior: Clip.none,
//             alignment: AlignmentDirectional.bottomEnd,
//             children: [
//               Positioned(
//                 top: 20,
//                 right: 20,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Text(
//                       agentName ?? 'Loading...',
//                       style: TextStyle(
//                         color: Theme.of(context).textTheme.titleMedium!.color,
//                         fontFamily:
//                             Theme.of(context).textTheme.titleMedium!.fontFamily,
//                         fontSize:
//                             Theme.of(context).textTheme.titleMedium!.fontSize,
//                       ),
//                     ),
//                     Text(
//                       agentRoleName ?? 'Loading...',
//                       style: TextStyle(
//                         fontFamily:
//                             Theme.of(context).textTheme.titleSmall!.fontFamily,
//                         fontSize:
//                             Theme.of(context).textTheme.titleSmall!.fontSize,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: Image.network(agentPhotoUrl!,
//                     fit: BoxFit.fitHeight,
//                     height: 610, loadingBuilder: (BuildContext context,
//                         Widget child, ImageChunkEvent? loadingProgress) {
//                   if (loadingProgress == null) {
//                     return child;
//                   }
//                   return const SizedBox(height: 500);
//                 }),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.all(20),
//             child: Row(
//               children: [
//                 AgentInfoButton(
//                   onPressed: () {
//                     setState(() {
//                       isPressedFavorite = !isPressedFavorite;
//                     });
//                   },
//                   buttonText: isPressedFavorite ? "FAVORITED" : "FAVORITE",
//                   backgroundColor: isPressedFavorite
//                       ? Theme.of(context).indicatorColor
//                       : Theme.of(context).hoverColor,
//                 ),
//                 const SizedBox(width: 5),
//                 AgentInfoButton(
//                   buttonText: "VIEW CONTRACT",
//                   backgroundColor: Theme.of(context).hoverColor,
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => AgentDetailsPage(
//                           agentName: agentName!,
//                           agentPhotoUrl: agentPhotoUrl!,
//                           agentDescription: agentDescription!,
//                           agentRole: agentRoleName ?? 'Loading',
//                           agentRoleIcon: agentRoleIcon ?? 'Loading',
//                           agentRoleDescription:
//                               agentRoleDescription ?? 'Loading',
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//           AgentTab(
//             color: Theme.of(context).indicatorColor,
//             onAgentSelected: updateSelectedAgent,
//           ),
//         ],
//       ),
//     ));
//   }
// }

// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:valinfo/components/agent_info_button.dart';
// import 'package:valinfo/components/agent_tabbar.dart';
// import 'specific_agent_info.dart';

// class AgentInfo extends StatefulWidget {
//   final dynamic agent;

//   const AgentInfo({
//     required this.agent,
//     super.key,
//   });

//   @override
//   AgentInfoState createState() => AgentInfoState();
// }

// class AgentInfoState extends State<AgentInfo> {
//   String? agentName;
//   String? agentPhotoUrl;
//   String? agentDescription;
//   String? agentIcon;

//   String? agentRoleName;
//   String? agentRoleIcon;
//   String? agentRoleDescription;

//   bool isPressedFavorite = false;
//   late PageController _pageController;
//   int _currentPageIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//     fetchAgentData(widget.agent);
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   // Function to fetch agent data
//   void fetchAgentData(dynamic agent) {
//     log("Fetching data for: ${agent['displayName']} : ${agent['role'] != null ? agent['role']['displayName'] : null}");

//     setState(() {
//       agentName = agent['displayName'];
//       agentPhotoUrl = agent['fullPortrait'];
//       agentDescription = agent['description'];
//       agentRoleName =
//           agent['role'] != null ? agent['role']['displayName'] : null;
//       agentRoleIcon =
//           agent['role'] != null ? agent['role']['displayIcon'] : null;
//       agentRoleDescription =
//           agent['role'] != null ? agent['role']['description'] : null;
//     });
//   }

//   void updateSelectedAgent(Map<String, dynamic> selectedAgent) {
//     setState(() {
//       // _currentPageIndex = selectedAgent['index'];
//       fetchAgentData(selectedAgent['agent']);
//       _pageController.jumpToPage(_currentPageIndex);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//             decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//               colors: [Color(0xff3e606c), Color(0xff4c7a8a), Color(0xff222042)],
//               stops: [0, 0.12, 1],
//               begin: Alignment(-0.4, -1.0),
//               end: Alignment(1.9, 2.3),
//             )),
//             child:
//                 Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//               Expanded(
//                   child: PageView.builder(
//                       controller: _pageController,
//                       itemCount:
//                           24, // Assuming you have the agents list available
//                       onPageChanged: (index) {
//                         setState(() {
//                           _currentPageIndex = index;
//                           List<dynamic> agents =
//                               []; // Add this line to define the 'agents' field

//                           fetchAgentData(agents[
//                               index]); // Update the code to use the 'agents' field
//                         });
//                       },
//                       itemBuilder: (context, index) {
//                         return Column(
//                           children: [
//                             Stack(
//                               clipBehavior: Clip.none,
//                               alignment: AlignmentDirectional.bottomEnd,
//                               children: [
//                                 Positioned(
//                                   top: 20,
//                                   right: 20,
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     children: [
//                                       Text(
//                                         agentName ?? 'Loading...',
//                                         style: TextStyle(
//                                           color: Theme.of(context)
//                                               .textTheme
//                                               .titleMedium!
//                                               .color,
//                                           fontFamily: Theme.of(context)
//                                               .textTheme
//                                               .titleMedium!
//                                               .fontFamily,
//                                           fontSize: Theme.of(context)
//                                               .textTheme
//                                               .titleMedium!
//                                               .fontSize,
//                                         ),
//                                       ),
//                                       Text(
//                                         agentRoleName ?? 'Loading...',
//                                         style: TextStyle(
//                                           fontFamily: Theme.of(context)
//                                               .textTheme
//                                               .titleSmall!
//                                               .fontFamily,
//                                           fontSize: Theme.of(context)
//                                               .textTheme
//                                               .titleSmall!
//                                               .fontSize,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8),
//                                   child: Image.network(agentPhotoUrl!,
//                                       fit: BoxFit.fitHeight, height: 610,
//                                       loadingBuilder: (BuildContext context,
//                                           Widget child,
//                                           ImageChunkEvent? loadingProgress) {
//                                     if (loadingProgress == null) {
//                                       return child;
//                                     }
//                                     return const SizedBox(height: 500);
//                                   }),
//                                 ),
//                               ],
//                             ),
//                             AgentTab(
//                               color: Theme.of(context).indicatorColor,
//                               onAgentSelected: updateSelectedAgent,
//                             ),
//                           ],
//                         );
//                       }))
//             ])));
//   }
// }

// // Padding(
// //                         padding: const EdgeInsets.all(20),
// //                         child: Row(
// //                           children: [
// //                             AgentInfoButton(
// //                               onPressed: () {
// //                                 setState(() {
// //                                   isPressedFavorite = !isPressedFavorite;
// //                                 });
// //                               },
// //                               buttonText:
// //                                   isPressedFavorite ? "FAVORITED" : "FAVORITE",
// //                               backgroundColor: isPressedFavorite
// //                                   ? Theme.of(context).indicatorColor
// //                                   : Theme.of(context).hoverColor,
// //                             ),
// //                             const SizedBox(width: 5),
// //                             AgentInfoButton(
// //                               buttonText: "VIEW CONTRACT",
// //                               backgroundColor: Theme.of(context).hoverColor,
// //                               onPressed: () {
// //                                 Navigator.push(
// //                                   context,
// //                                   MaterialPageRoute(
// //                                     builder: (context) => AgentDetailsPage(
// //                                       agentName: agentName!,
// //                                       agentPhotoUrl: agentPhotoUrl!,
// //                                       agentDescription: agentDescription!,
// //                                       agentRole: agentRoleName ?? 'Loading',
// //                                       agentRoleIcon: agentRoleIcon ?? 'Loading',
// //                                       agentRoleDescription:
// //                                           agentRoleDescription ?? 'Loading',
// //                                     ),
// //                                   ),
// //                                 );
// //                               },
// //                             ),
// //                           ],

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
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

  bool isPressedFavorite = false;

  late PageController _pageController;
  int _currentPageIndex = 0;
  List<dynamic> agents = []; // Store the agents list
  List<bool> isFavorite = []; // Store favorites in list

  late Future<void> _dataFuture;

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
    await fetchAgentData(widget.agent);
  }

  // Function to fetch agent data
  Future<void> fetchAgentData(dynamic agent) async {
    log("Fetching data for: ${agent['displayName']} : ${agent['role'] != null ? agent['role']['displayName'] : null}"); // Debug

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

  // Update screen based on selected agent
  void updateSelectedAgent(Map<String, dynamic> selectedAgent) {
    setState(() {
      _currentPageIndex = selectedAgent['index'];
      fetchAgentData(selectedAgent['agent']);
      _pageController.jumpToPage(_currentPageIndex);
    });
  }

  // Add agent to favorites
  void addToFavorite(Map<String, dynamic> selectedAgent) {
    setState(() {
      isFavorite[selectedAgent['index']] = !isFavorite[selectedAgent['index']];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<void>(
            future: _dataFuture, // Initialize data before construction
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child:
                        CircularProgressIndicator()); // Show a loading spinner
              } else if (snapshot.hasError) {
                return const Center(
                    child: Text('Error loading data')); // Handle errors
              } else {
                return Container(
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
                    child: Column(
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
                                          top: 20,
                                          right: 20,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
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
                                              Text(
                                                agentRoleName ?? 'Loading...',
                                                style: TextStyle(
                                                  fontFamily: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .fontFamily,
                                                  fontSize: 16,
                                                ),
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
                                            return const SizedBox(height: 500);
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
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: AgentTab(
                              color: Theme.of(context).hoverColor,
                              onAgentSelected: updateSelectedAgent,
                              currentIndex:
                                  _currentPageIndex, // Pass the current index
                              agents: agents, // Pass the agents list
                            ),
                          ),
                        ]));
              }
            }));
  }
}
