import 'package:flutter/material.dart';
import '../services/deck_service.dart';
import 'study_session_screen.dart';
import 'summary_screen.dart'; // <-- make sure this path is correct
import 'package:provider/provider.dart';
import '../state/deck_state.dart';

class DeckSelectionScreen extends StatelessWidget {
  const DeckSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            return Center(
              child: Text('Error loading data: ${snapshot.error}'),
            );
          }

          final decks = snapshot.data;

          if (decks == null || decks.isEmpty) {
            return const Center(
              child: Text('No decks found. Check your JSON file.'),
            );
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          // ----------------------
                          // Session end logic
                          // ----------------------
                          void endSessionLogic() {
                            final mastered = deck.cards
                                .where((c) => c.isMastered)
                                .length;

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SummaryScreen(
                                  totalCards: deck.cards.length,
                                  masteredCount: mastered,
                                ),
                              ),
                            );
                          }

                          return ChangeNotifierProvider(
                            create: (context) => DeckState(
                              deck,
                              onSessionEnd: endSessionLogic,
                            ),
                            child: const StudySessionScreen(),
                          );
                        },
                      ),
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
