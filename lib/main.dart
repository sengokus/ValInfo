import 'package:flutter/material.dart';
import 'package:valinfo/pages/specific_agent_info.dart';
// import 'package:valinfo/agent_tabbar.dart';
// import 'package:google_fonts/google_fonts.dart'; // Package to use Google Fonts

import 'package:valinfo/pages/agent_info.dart';
import 'package:valinfo/pages/onboarding.dart';
import 'package:valinfo/utils/riotapi.dart';

import 'package:valinfo/pages/agentt.dart';
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
      initialRoute: '/',
      routes: {
        //'/' : (context) => AgentInfoo(agent: agentData), // debugging

        //'/': (context) => const Onboarding(),
        '/': (context) => AgentInfo(agent: agentData),
        'specificAgentPage': (context) {
          final agentName = agentData['displayName'] ?? '';
          final agentPhotoUrl = agentData['fullPortrait'] ?? '';
          final agentDescription = agentData['description'] ?? '';
          final agentRoleName = agentData['agentRoleName'] ?? '';
          final agentRoleIcon = agentData['role']['displayIcon'] ?? '';
          final agentRoleDescription = agentData['agentRoleName'] ?? '';
          
          final agentAbility1Name = agentData['abilities'][0]['displayName'] ?? '';
          final agentAbility1Icon = agentData['abilities'][0]['displayIcon'] ?? '';
          final agentAbility1Description = agentData['abilities'][0]['description'] ?? '';

          final agentAbility2Name = agentData['abilities'][1]['displayName'] ?? '';
          final agentAbility2Icon = agentData['abilities'][1]['displayIcon'] ?? '';
          final agentAbility2Description = agentData['abilities'][1]['description'] ?? '';

          final agentAbility3Name = agentData['abilities'][2]['displayName'] ?? '';
          final agentAbility3Icon = agentData['abilities'][2]['displayIcon'] ?? '';
          final agentAbility3Description = agentData['abilities'][2]['description'] ?? '';

          final agentAbility4Name = agentData['abilities'][3]['displayName'] ?? '';
          final agentAbility4Icon = agentData['abilities'][3]['displayIcon'] ?? '';
          final agentAbility4Description = agentData['abilities'][3]['description'] ?? '';

          //final agentAbilities = agentData['abilities']?.cast<String>() ?? [];
          return AgentDetailsPage(
            agentName: agentName,
            agentPhotoUrl: agentPhotoUrl,
            agentDescription: agentDescription,
            agentRole: agentRoleName,
            agentRoleDescription: agentRoleDescription,
            agentRoleIcon: agentRoleIcon,
            agentAbility1Name: agentAbility1Name,
            agentAbility1Description: agentAbility1Description,
            agentAbility1Icon: agentAbility1Icon,
            agentAbility2Name: agentAbility2Name,
            agentAbility2Description: agentAbility2Description,
            agentAbility2Icon: agentAbility2Icon,
            agentAbility3Name: agentAbility3Name,
            agentAbility3Description: agentAbility3Description,
            agentAbility3Icon: agentAbility3Icon,
            agentAbility4Name: agentAbility4Name,
            agentAbility4Description: agentAbility4Description,
            agentAbility4Icon: agentAbility4Icon,
            
            //agentAbilities: agentAbilities,
          );
        },
      },
    );
  }
}
