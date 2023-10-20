class CarModel {
  final String id;
  final String category;
  final String engineCC;
  final String fuelType;
  final double value;
  final int? timeStamp;

  CarModel(
      {required this.id,
      required this.category,
      required this.engineCC,
      required this.fuelType,
      required this.value,
      this.timeStamp});

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'] ?? '',
      category: json['category'] ?? '',
      engineCC: json['engineCC'] ?? '',
      fuelType: json['fuelType'] ?? '',
      timeStamp: json['createdtAt'] ?? 0,
      value: (json['value'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': timeStamp,
      'category': category,
      'engineCC': engineCC,
      'fuelType': fuelType,
      'value': value,
    };
  }
}
