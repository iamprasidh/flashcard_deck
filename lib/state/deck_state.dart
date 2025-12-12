// lib/state/deck_state.dart
import 'package:flutter/material.dart';
import '../services/deck_service.dart';
import '../models/flashcard.dart';

// ✅ 1. Callback type
typedef SessionEndCallback = void Function();

class DeckState extends ChangeNotifier {
  final StudyDeck _deck; 
  int _currentCardIndex = 0;

  // Cards to review
  List<Flashcard> _cardsToReview = [];

  // ✅ 2. Callback for session end
  final SessionEndCallback onSessionEnd;

  // ✅ 3. Updated constructor — callback is required
  DeckState(this._deck, {required this.onSessionEnd}) {
    _cardsToReview = List.from(_deck.cards);
  }

  // Getters
  StudyDeck get deck => _deck;
  List<Flashcard> get cardsToReview => _cardsToReview;
  int get currentCardIndex => _currentCardIndex;
  Flashcard get currentCard => _cardsToReview[_currentCardIndex];
  bool get isLastCard => _currentCardIndex == _cardsToReview.length - 1;

  // ✅ 4. Updated next card logic
  void moveToNextCard() {
    if (!isLastCard) {
      _currentCardIndex++;
      notifyListeners();
    } else {
      // 🔥 Trigger the end-of-session callback
      onSessionEnd();
    }
  }

  // Mastered
  void markAsMastered() {
    final masteredCard = currentCard.copyWith(isMastered: true);
    _cardsToReview[_currentCardIndex] = masteredCard;
    moveToNextCard();
  }

  // Need review
  void markForReview() {
    moveToNextCard();
  }
}
