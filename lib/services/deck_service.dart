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
      return StudyDeck(
        deckId: jsonDeck['deckId'],
        deckName: jsonDeck['deckName'],
        cards: [],
      );
    }).toList();
  }
}