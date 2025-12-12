// lib/state/deck_state.dart
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';       // Hive for persistence
import '../services/deck_service.dart';
import '../models/flashcard.dart';

// 1. Callback type
typedef SessionEndCallback = void Function();

class DeckState extends ChangeNotifier {
  final StudyDeck _deck;
  int _currentCardIndex = 0;

  List<Flashcard> _cardsToReview = [];

  // Callback for session end
  final SessionEndCallback onSessionEnd;

  // Constructor
  DeckState(this._deck, {required this.onSessionEnd}) {
    _cardsToReview = List.from(_deck.cards);
  }

  // Getters
  StudyDeck get deck => _deck;
  List<Flashcard> get cardsToReview => _cardsToReview;
  int get currentCardIndex => _currentCardIndex;
  Flashcard get currentCard => _cardsToReview[_currentCardIndex];
  bool get isLastCard => _currentCardIndex == _cardsToReview.length - 1;

  // ----------------------------------------------------------
  // 🔥 NEW: Mastered Count Getter
  // ----------------------------------------------------------
  int get masteredCount =>
      _cardsToReview.where((card) => card.isMastered).length;

  // ----------------------------------------------------------
  // SAVE CARD STATUS TO HIVE
  // ----------------------------------------------------------
  Future<void> _saveCardStatus(Flashcard card) async {
    final box = await Hive.openBox<Flashcard>('mastery_status');
    await box.put(card.id, card);
  }

  // ----------------------------------------------------------
  // Move to next card
  // ----------------------------------------------------------
  void moveToNextCard() {
    if (!isLastCard) {
      _currentCardIndex++;
      notifyListeners();
    } else {
      onSessionEnd();
    }
  }

  // ----------------------------------------------------------
  // Mark as Mastered
  // ----------------------------------------------------------
  void markAsMastered() {
    final masteredCard = currentCard.copyWith(isMastered: true);
    _cardsToReview[_currentCardIndex] = masteredCard;

    // Save to Hive
    _saveCardStatus(masteredCard);

    moveToNextCard();
  }

  // ----------------------------------------------------------
  // Mark for Review
  // ----------------------------------------------------------
  void markForReview() {
    final reviewedCard = currentCard.copyWith(isMastered: false);
    _cardsToReview[_currentCardIndex] = reviewedCard;

    // Save to Hive
    _saveCardStatus(reviewedCard);

    moveToNextCard();
  }
}
