import 'package:expense_tracker_mobile/data/models/response/category_response.dart';

class CategoryDto {
  final int id;
  final String name;

  CategoryDto({required this.id, required this.name});

  factory CategoryDto.fromCategoryResponse(CategoryResponse response) {
    return CategoryDto(id: response.id, name: response.name);
  }

  static List<CategoryDto> fromCategoryResponseList(List<CategoryResponse> responses) {
    return responses.map((response) => CategoryDto.fromCategoryResponse(response)).toList();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryDto && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'CategoryDto{id: $id, name: $name}';
}
