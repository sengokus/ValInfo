import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart'; // Package to use Google Fonts

import 'agent_info.dart';
import 'onboarding.dart';
import 'riotapi.dart';

void main() {
  runApp(const MainApp());
  fetchValApiData();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 250, 68, 84),
          brightness: Brightness.dark,
        ),
        // 
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
        '/agentInfoPage': (context) => const AgentInfo(),
      },
    );
  }
}
