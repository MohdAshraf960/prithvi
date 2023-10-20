class SurveyModel {
  final String id; // Unique identifier for the survey
  final String title;
  final String description;
  final num categoryTotal;

  SurveyModel({
    required this.id,
    required this.title,
    required this.description,
    required this.categoryTotal,
  });

  // Factory constructor to create a SurveyModel from a Map
  factory SurveyModel.fromJson(Map<String, dynamic> json) {
    return SurveyModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      categoryTotal: json['categoryTotal'] ?? 0,
    );
  }

  // Convert SurveyModel to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'categoryTotal': categoryTotal,
    };
  }
}
