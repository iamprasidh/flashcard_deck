// lib/state/deck_state.dart
import 'package:flutter/material.dart';
import '../services/deck_service.dart';
import '../models/flashcard.dart';

class DeckState extends ChangeNotifier {
  final StudyDeck _deck; // The original deck data
  int _currentCardIndex = 0;
  
  // A temporary list to track cards that need review (initially all cards)
  List<Flashcard> _cardsToReview = []; 

  // Constructor: Takes the deck data and initializes the state
  DeckState(this._deck) {
    _cardsToReview = List.from(_deck.cards); // Start with all cards
  }

  // Getters: Publicly expose the state data
  List<Flashcard> get cardsToReview => _cardsToReview;
  int get currentCardIndex => _currentCardIndex;
  Flashcard get currentCard => _cardsToReview[_currentCardIndex];
  bool get isLastCard => _currentCardIndex == _cardsToReview.length - 1;

  // Action: Moves to the next card
  void moveToNextCard() {
    if (!isLastCard) {
      _currentCardIndex++;
      // Notify all widgets listening to this state that the index changed.
      notifyListeners(); 
    } else {
      // TODO: Handle session end (e.g., navigate to summary screen)
      print("Session Complete!"); 
    }
  }

  // Action: Marks a card as mastered (moves it out of the review list)
  void markAsMastered() {
    // 1. Mark the current card as mastered (using the copyWith method you learned!)
    final masteredCard = currentCard.copyWith(isMastered: true);
    
    // 2. Remove the OLD card and insert the NEW mastered card into the list 
    //    (to show you how to update immutable data in a list).
    _cardsToReview[_currentCardIndex] = masteredCard;
    
    // 3. Move to the next card immediately.
    moveToNextCard();
  }

  // Action: Marks a card for review (simply moves to the next card)
  void markForReview() {
    // We don't change the card state, just move on
    moveToNextCard();
  }
}