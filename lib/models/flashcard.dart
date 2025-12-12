class Flashcard {
  final String id;
  final String question;
  final String answer;
  final bool isMastered;

  Flashcard({
    required this.id,
    required this.question,
    required this.answer,
    required this.isMastered,
  });

  factory Flashcard.fromJson(Map<String, dynamic> json) {
    return Flashcard(
      id: json['id'] as String,
      question: json['question'] as String,
      answer: json['answer'] as String,
      isMastered: json['isMastered'] as bool? ?? false,
    );
  }

  Flashcard copyWith({
    String? id,
    String? question,
    String? answer,
    bool? isMastered,
  }) {
    return Flashcard(
      id: id ?? this.id,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      isMastered: isMastered ?? this.isMastered,
    );
  }
}