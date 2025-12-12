import 'package:hive/hive.dart'; // Import Hive

part 'flashcard.g.dart'; // REQUIRED: tells Dart to look for the generated file

// Add the HiveType annotation with a unique ID for this model (e.g., 0)
@HiveType(typeId: 0)
class Flashcard {
  // Use the HiveField annotation for each property you want to save
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String question;
  @HiveField(2)
  final String answer;
  @HiveField(3)
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