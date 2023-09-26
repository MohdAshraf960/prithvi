// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

enum QuestionType { Input, MCQ, Slider }

class QuestionModel {
  final String text;
  final QuestionType type;
  final List<String> options;
  final double calculationFactor;
  final DocumentReference categoryRef;
  final int timestamp;

  QuestionModel({
    required this.text,
    required this.type,
    required this.options,
    required this.calculationFactor,
    required this.categoryRef,
    required this.timestamp,
  });

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    // Map the type string to the enum value
    QuestionType questionType;
    switch (map['type']) {
      case 'Input':
        questionType = QuestionType.Input;
        break;
      case 'MCQ':
        questionType = QuestionType.MCQ;
        break;
      case 'Slider':
        questionType = QuestionType.Slider;
        break;
      default:
        questionType = QuestionType.Input;
    }
    return QuestionModel(
      text: map['text'] ?? '',
      type: questionType,
      options: List<String>.from(map['options'] ?? []),
      calculationFactor: (map['calculationFactor'] as num?)?.toDouble() ?? 0.0,
      categoryRef: map['categoryRef'] ?? '',
      timestamp: map['createdAt'] ?? DateTime.now().millisecondsSinceEpoch,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'type': type.toString().split('.').last,
      'options': options,
      'calculationFactor': calculationFactor,
      'categoryRef': categoryRef,
      'createdAt': timestamp,
    };
  }

  // Convert QuestionModel to JSON
  Map<String, dynamic> toJson() => toMap();

  // Create a factory method to create a QuestionModel from JSON
  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      QuestionModel.fromMap(json);

  @override
  String toString() {
    return 'QuestionModel(text: $text, type: $type, options: $options, calculationFactor: $calculationFactor, categoryRef: $categoryRef, createdAt: $timestamp)';
  }
}



//**
//  question 1 * factor 
// */