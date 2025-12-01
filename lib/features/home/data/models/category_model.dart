class CategoryModel {
  final String name;

  const CategoryModel({required this.name});

  factory CategoryModel.fromJson(String json) {
    return CategoryModel(name: json);
  }

  String toJson() => name;
}

