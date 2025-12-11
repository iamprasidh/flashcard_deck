import 'package:flutter/material.dart';
import 'screens/deck_selection_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'Flashcard Deck',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:const DeckSelectionScreen(),
    );
  }
}