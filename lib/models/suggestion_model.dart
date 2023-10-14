class SuggestionModel {
  final int id;
  final String suggestion;
  final int color;

  SuggestionModel({
    required this.id,
    required this.suggestion,
    required this.color,
  });

  factory SuggestionModel.fromJson(Map<String, dynamic> json) {
    return SuggestionModel(
      id: json['id'],
      suggestion: json['suggestion'],
      color: json['color'],
    );
  }
}
