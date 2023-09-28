// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

enum QuestionType { Input, MCQ, Slider }

class QuestionModel {
  String text;
  QuestionType type;
  List<Option> options;
  double calculationFactor;
  DocumentReference categoryRef;
  int timestamp;
  String unit;

  QuestionModel(
      {required this.text,
      required this.type,
      required this.options,
      required this.calculationFactor,
      required this.categoryRef,
      required this.timestamp,
      required this.unit});

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
        options: (map['options'] as List<dynamic>)
            .map((e) => Option.fromMap(e))
            .toList(),
        calculationFactor:
            (map['calculationFactor'] as num?)?.toDouble() ?? 0.0,
        categoryRef: map['categoryRef'] ?? '',
        timestamp: map['createdAt'] ?? DateTime.now().millisecondsSinceEpoch,
        unit: map['unit']);
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'type': type.toString().split('.').last,
      'options': options.map((e) => e.toMap()).toList(),
      'calculationFactor': calculationFactor,
      'categoryRef': categoryRef,
      'createdAt': timestamp,
      'unit': unit
    };
  }

  // Convert QuestionModel to JSON
  Map<String, dynamic> toJson() => toMap();

  // Create a factory method to create a QuestionModel from JSON
  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      QuestionModel.fromMap(json);

  @override
  String toString() {
    return 'QuestionModel(text: $text, type: $type, options: $options, calculationFactor: $calculationFactor, categoryRef: $categoryRef, createdAt: $timestamp,unit: $unit)';
  }
}

class Option {
  String key;
  double value;
  Option({required this.key, required this.value});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'key': key,
      'value': value,
    };
  }

  factory Option.fromMap(Map<String, dynamic> map) {
    return Option(
      key: map['key'] as String,
      value: map['value'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Option.fromJson(String source) =>
      Option.fromMap(json.decode(source) as Map<String, dynamic>);
}
