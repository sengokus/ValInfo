import 'package:flutter/material.dart';

class AgentDetailsPage extends StatelessWidget {
  final String agentName;
  final String agentPhotoUrl;
  final String agentDescription;

  const AgentDetailsPage({
    required this.agentName,
    required this.agentPhotoUrl,
    required this.agentDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              agentName,
              style: TextStyle(
                color: Theme.of(context).textTheme.titleMedium!.color,
                fontFamily: Theme.of(context).textTheme.titleMedium!.fontFamily,
                fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Image.network(
                agentPhotoUrl,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                agentDescription,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.5,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
