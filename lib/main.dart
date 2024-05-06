import 'package:flutter/material.dart';
import 'package:valinfo/agent_info.dart';
import 'package:valinfo/riotapi.dart';

import 'onboarding.dart';


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
          // brightness: Brightness.dark,
        ),
        // 
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontFamily: 'Valorant',
            fontSize: 60, 
            fontWeight: FontWeight.bold
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
