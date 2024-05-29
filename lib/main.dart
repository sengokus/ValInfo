import 'package:flutter/material.dart';
import 'package:valinfo/pages/specific_agent_info.dart';
// import 'package:valinfo/agent_tabbar.dart';
// import 'package:google_fonts/google_fonts.dart'; // Package to use Google Fonts

import 'package:valinfo/pages/agent_info.dart';
import 'package:valinfo/pages/onboarding.dart';
import 'package:valinfo/utils/riotapi.dart';

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
      // onGenerateRoute: (settings) {
      //   if (settings.name == '/agentInfoPage') {
      //     return PageRouteBuilder(
      //         pageBuilder: (_, __, ___) => AgentInfo(agent: agentData));
      //   }

      //   return null;
      // },
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 250, 68, 84),
          brightness: Brightness.dark,
        ),
        primaryColor: const Color.fromARGB(255, 250, 68, 84),
        indicatorColor: const Color.fromARGB(99, 118, 225, 255),
        hoverColor: const Color.fromARGB(20, 219, 219, 219),
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
            titleSmall: TextStyle(
              fontFamily: 'Din Next',
              fontSize: 12,
            )),
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
          final agentRoleName = agentData['agentRoleName'] ?? '' ;
          //final agentAbilities = agentData['abilities']?.cast<String>() ?? [];
          return AgentDetailsPage(
            agentName: agentName,
            agentPhotoUrl: agentPhotoUrl,
            agentDescription: agentDescription,
            agentRole: agentRoleName,
            //agentAbilities: agentAbilities,
          );
        },
      },
    );
  }
}
