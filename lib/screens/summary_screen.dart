// lib/screens/summary_screen.dart
import 'package:flutter/material.dart';

class SummaryScreen extends StatelessWidget {
  final int totalCards;
  final int masteredCount;

  const SummaryScreen({
    super.key,
    required this.totalCards,
    required this.masteredCount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Complete'),
        automaticallyImplyLeading: false, // Prevents the back button
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Deck Finished!',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Mastered: $masteredCount out of $totalCards',
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Returns to the Deck Selection Screen (the Home screen)
                Navigator.popUntil(context, (route) => route.isFirst); 
              },
              child: const Text('Start New Session'),
            ),
          ],
        ),
      ),
    );
  }
}