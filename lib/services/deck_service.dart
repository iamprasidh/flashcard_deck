import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/flashcard.dart';

class StudyDeck {
  final String deckId;
  final String deckName;
  final List<Flashcard> cards;

  StudyDeck({required this.deckId, required this.deckName, required this.cards});
}

class DeckService {
  Future<List<StudyDeck>> LoadAllDecks() async {
    final String jsonString = await rootBundle.loadString('assets/decks.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    return jsonList.map((jsonDeck) {
        // 1. Get the list of raw card maps from the current deck
        final List<dynamic> rawCards = jsonDeck['cards'] as List<dynamic>;

        // 2. Convert the raw list into a list of Flashcard objects
        final List<Flashcard> structuredCards = rawCards
            .map((cardJson) => Flashcard.fromJson(cardJson as Map<String, dynamic>))
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