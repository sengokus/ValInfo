import 'package:flutter/material.dart';
import 'package:valinfo/pages/specific_agent_info.dart';
// import 'package:valinfo/agent_tabbar.dart';
// import 'package:google_fonts/google_fonts.dart'; // Package to use Google Fonts

import 'pages/agent_info.dart';
import 'pages/onboarding.dart';
import 'utils/riotapi.dart';

void main() {
  fetchValApiData().then((agentData) {
    runApp(MainApp(agentData: agentData));
  });
}

class MainApp extends StatelessWidget {
  final Map<String, dynamic> agentData;

  const MainApp({
    required this.agentData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 250, 68, 84),
          brightness: Brightness.dark,
        ),
        
        primaryColor: const Color.fromARGB(255, 250, 68, 84),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontFamily: 'Valorant',
            fontSize: 60, 
          ),

          titleMedium: TextStyle(
            color: Color.fromARGB(255, 235, 240, 176),
            fontFamily: 'Bebas Neue',
            fontSize: 60,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/agentInfoPage',
      routes: {
        '/': (context) => const Onboarding(),
        '/agentInfoPage': (context) => AgentInfo(agent: agentData),
        'specificAgentPage': (context) {
          final agentName = agentData['displayName'] ?? '';
          final agentPhotoUrl = agentData['fullPortrait'] ?? '';
          final agentDescription = agentData['description'] ?? '';
          return AgentDetailsPage(
            agentName: agentName,
            agentPhotoUrl: agentPhotoUrl,
            agentDescription: agentDescription,
          );
        },
      },
    );
  }
}
