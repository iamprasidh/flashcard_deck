import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/flashcard.dart';
import 'package:hive/hive.dart'; // NEW: Hive

class StudyDeck {
  final String deckId;
  final String deckName;
  final List<Flashcard> cards;

  StudyDeck({required this.deckId, required this.deckName, required this.cards});
}

class DeckService {
  Future<List<StudyDeck>> LoadAllDecks() async {
    // 1. Open the Hive Box (the database container)
    // We name the box 'mastery_status'
    final box = await Hive.openBox<Flashcard>('mastery_status');

    // 2. Load the default data (your JSON logic)
    final String jsonString = await rootBundle.loadString('assets/decks.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    return jsonList.map((jsonDeck) {
        // 1. Get the list of raw card maps from the current deck
        final List<dynamic> rawCards = jsonDeck['cards'] as List<dynamic>;

        // 2. Convert the raw list into a list of Flashcard objects
        final List<Flashcard> structuredCards = rawCards.map((cardJson) {
            final Flashcard defaultCard = Flashcard.fromJson(cardJson as Map<String, dynamic>);
            
            // Check Hive for a saved version of this card
            final Flashcard? savedCard = box.get(defaultCard.id); 
            
            // If a saved version exists, use it; otherwise, use the default JSON card.
            return savedCard ?? defaultCard;
          })
          .toList();

        // 3. Return the fully structured StudyDeck
        return StudyDeck(
          deckId: jsonDeck['deckId'],
          deckName: jsonDeck['deckName'],
          cards: structuredCards, 
        );
      }).toList();
  }
}  