import 'package:flutter/material.dart';
import '../services/deck_service.dart'; 

class DeckSelectionScreen extends StatelessWidget {
  const DeckSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Instantiate the service.
    final deckService = DeckService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Deck'),
      ),
      
      body: FutureBuilder<List<StudyDeck>>(
        future: deckService.LoadAllDecks(),
        builder: (context, snapshot) {
  
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error loading data: ${snapshot.error}'));
          }

          final List<StudyDeck>? decks = snapshot.data;
          
          if (decks == null || decks.isEmpty) {
            return const Center(child: Text('No decks found. Check your JSON file.'));
          }

          return ListView.builder(
            itemCount: decks.length,
            itemBuilder: (context, index) {
              final deck = decks[index];
              return Card(
                child: ListTile(
                  title: Text(deck.deckName),
                  subtitle: Text('${deck.cards.length} cards'),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Starting ${deck.deckName}...')),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}