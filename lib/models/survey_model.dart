class Survey {
  final String userId;
  final List<SubcollectionData> subcollections;

  Survey({
    required this.userId,
    required this.subcollections,
  });

  factory Survey.fromJson(Map<String, dynamic> json) {
    final subcollectionList = (json['subcollections'] as List)
        .map((subcollectionJson) =>
            SubcollectionData.fromJson(subcollectionJson))
        .toList();

    return Survey(
      userId: json['userId'] as String,
      subcollections: subcollectionList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'subcollections': subcollections
          .map((subcollection) => subcollection.toJson())
          .toList(),
    };
  }
}

class SubcollectionData {
  final String name;
  final List<SubcollectionDocument> documents;

  SubcollectionData({
    required this.name,
    required this.documents,
  });

  factory SubcollectionData.fromJson(Map<String, dynamic> json) {
    final documentList = (json['documents'] as List)
        .map((documentJson) => SubcollectionDocument.fromJson(documentJson))
        .toList();

    return SubcollectionData(
      name: json['name'] as String,
      documents: documentList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'documents': documents.map((document) => document.toJson()).toList(),
    };
  }
}

class SubcollectionDocument {
  final String answerId;
  final String answer;
  final dynamic calculation; // Can be int, double, or String
  final String questionId;

  SubcollectionDocument({
    required this.answerId,
    required this.answer,
    required this.calculation,
    required this.questionId,
  });

  factory SubcollectionDocument.fromJson(Map<String, dynamic> json) {
    return SubcollectionDocument(
      answerId: json['answerId'] as String,
      answer: json['answer'] as String,
      calculation:
          json['calculation'], // Dynamic type, can be int, double, or String
      questionId: json['questionId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'answerId': answerId,
      'answer': answer,
      'calculation': calculation,
      'questionId': questionId,
    };
  }
}
