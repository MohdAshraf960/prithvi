class CarModel {
  final String category;
  final String engineCC;
  final String fuelType;
  final double value;

  CarModel({
    required this.category,
    required this.engineCC,
    required this.fuelType,
    required this.value,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      category: json['category'] ?? '',
      engineCC: json['engineCC'] ?? '',
      fuelType: json['fuelType'] ?? '',
      value: (json['value'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'engineCC': engineCC,
      'fuelType': fuelType,
      'value': value,
    };
  }
}
