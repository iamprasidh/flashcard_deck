// lib/screens/study_session_screen.dart
import 'package:flutter/material.dart';
import '../services/deck_service.dart'; // Import the StudyDeck model

// This screen is StatelessWidget because the actual card state will be local to the Flashcard Widget.
class StudySessionScreen extends StatelessWidget {
  final StudyDeck deck; // The entire deck is passed in the constructor

  const StudySessionScreen({super.key, required this.deck});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(deck.deckName),
        // Display the card count next to the title
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(child: Text('Total Cards: ${deck.cards.length}')),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          // We will use a dedicated widget here that handles the flashcard logic
          child: FlashcardWidget(
            flashcard: deck.cards.first, // Just showing the first card for now
            // TODO: In the next step, we will implement logic to cycle through all cards
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------------
// THE CORE WIDGET: FlashcardWidget
// This is where you will implement the 'flip' state using a StatefulWidget.
class FlashcardWidget extends StatefulWidget {
  final Flashcard flashcard;

  const FlashcardWidget({super.key, required this.flashcard});

  @override
  State<FlashcardWidget> createState() => _FlashcardWidgetState();
}

class _FlashcardWidgetState extends State<FlashcardWidget> {
  bool isAnswerShown = false; // Local state for the flip!

  void _toggleAnswer() {
    setState(() {
      isAnswerShown = !isAnswerShown;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleAnswer, // Tap the card to flip it
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          height: 300,
          width: double.infinity,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                // Use the local state to determine which text to show
                isAnswerShown ? "Answer:" : "Question:",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Text(
                // This is the content that flips
                isAnswerShown ? widget.flashcard.answer : widget.flashcard.question,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}