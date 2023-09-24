// ignore_for_file: public_member_api_docs, sort_constructors_first
class CategoryModel {
  final String name;
  final String type;
  final String image;

  CategoryModel({
    required this.name,
    required this.type,
    required this.image,
  });

  // Convert a CategoryModel object to a Map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'image': image,
    };
  }

  // Create a CategoryModel object from a Map
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'],
      type: json['type'],
      image: json['image'],
    );
  }

  @override
  String toString() => 'CategoryModel(name: $name, type: $type, image: $image)';
}
