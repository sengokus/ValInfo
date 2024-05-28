import 'package:flutter/material.dart';
import 'package:valinfo/pages/specific_agent_info.dart';
import 'package:valinfo/pages/agent_info.dart';
import 'package:valinfo/pages/onboarding.dart';
import 'package:valinfo/utils/riotapi.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'log_in.dart';
import 'sign_up_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
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
      initialRoute: '/login',
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
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/home': (context) => HomePage(agentData: agentData), // Create HomePage
      },
    );
  }
}

class HomePage extends StatelessWidget {
  final Map<String, dynamic> agentData;

  const HomePage({Key? key, required this.agentData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Text('Welcome!'),
      ),
    );
  }
}
