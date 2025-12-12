// lib/screens/study_session_screen.dart
import 'package:flutter/material.dart';
import '../models/flashcard.dart';
import 'package:provider/provider.dart';
import '../state/deck_state.dart';

class StudySessionScreen extends StatelessWidget {
  const StudySessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deckState = Provider.of<DeckState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(deckState.deck.deckName), // FIXED: use public getter
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                'Card ${deckState.currentCardIndex + 1} of ${deckState.cardsToReview.length}',
              ),
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),

            child: FlashcardWidget(
              key: ValueKey(deckState.currentCard.id),
              flashcard: deckState.currentCard,
            ),
          ),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: [
                ElevatedButton(
                  onPressed: deckState.markForReview,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Need Review', style: TextStyle(color: Colors.white)),
                ),

                ElevatedButton(
                  onPressed: deckState.markAsMastered,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text('Mastered', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------------------
// FlashcardWidget
// --------------------------------------------------------------

class FlashcardWidget extends StatefulWidget {
  final Flashcard flashcard;

  const FlashcardWidget({
    super.key,
    required this.flashcard,
  });

  @override
  State<FlashcardWidget> createState() => _FlashcardWidgetState();
}

class _FlashcardWidgetState extends State<FlashcardWidget> {
  bool isAnswerShown = false;

  void _toggleAnswer() {
    setState(() {
      isAnswerShown = !isAnswerShown;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleAnswer,
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
                isAnswerShown ? "Answer:" : "Question:",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 10),

              Text(
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
