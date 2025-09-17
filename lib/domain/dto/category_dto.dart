import 'package:expense_tracker_mobile/data/models/response/category_response.dart';

class CategoryDto {
  final int id;
  final String name;
  final int? usageCount;

  CategoryDto({required this.id, required this.name, this.usageCount = 0});

  factory CategoryDto.fromCategoryResponse(CategoryResponse response) {
    return CategoryDto(id: response.id, name: response.name, usageCount: response.usageCount);
  }

  static List<CategoryDto> fromCategoryResponseList(List<CategoryResponse> responses) {
  return responses.map((response) => CategoryDto.fromCategoryResponse(response)).toList();
  }
}
