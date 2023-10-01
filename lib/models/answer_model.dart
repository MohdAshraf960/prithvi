import 'package:cloud_firestore/cloud_firestore.dart';

class AnswerModel {
  String answerId;
  String userResponse;
  double calculatedValue;
  String questionId;
  DocumentReference categoryRef;
  int timestamp;

  AnswerModel({
    required this.answerId,
    required this.userResponse,
    required this.calculatedValue,
    required this.categoryRef,
    required this.questionId,
    required this.timestamp,
  });

  // Convert AnswerModel to a Map
  Map<String, dynamic> toMap() {
    return {
      'answerId': answerId,
      'userResponse': userResponse,
      'calculatedValue': calculatedValue,
      'questionId': questionId,
      'categoryRef': categoryRef,
      'createdAt': timestamp,
    };
  }

  // Create an AnswerModel from a Map
  factory AnswerModel.fromMap(Map<String, dynamic> map) {
    final categoryRef = map['categoryRef'] as DocumentReference;

    return AnswerModel(
      answerId: map['answerId'] ?? '',
      userResponse: map['userResponse'] ?? '',
      calculatedValue: (map['calculatedValue'] as num?)?.toDouble() ?? 0.0,
      questionId: map['questionId'] ?? '',
      categoryRef: categoryRef,
      timestamp: map['createdAt'] ?? DateTime.now().millisecondsSinceEpoch,
    );
  }

  // Convert AnswerModel to JSON
  Map<String, dynamic> toJson() => toMap();

  // Create an AnswerModel from JSON
  factory AnswerModel.fromJson(Map<String, dynamic> json) =>
      AnswerModel.fromMap(json);

  @override
  String toString() {
    return 'AnswerModel(answerId: $answerId, userResponse: $userResponse, calculatedValue: $calculatedValue, questionId: $questionId, categoryRef: $categoryRef, timestamp: $timestamp)';
  }
}

//
// category
// total
// answermodel
//
