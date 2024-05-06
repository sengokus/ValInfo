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
      debugShowCheckedModeBanner: false,
      initialRoute: '/agentInfoPage',
      routes: {
        '/': (context) => const Onboarding(),
        '/agentInfoPage': (context) => const AgentInfo(),
      },
    );
  }
}
