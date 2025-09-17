import 'package:json_annotation/json_annotation.dart';

part 'category_response.g.dart';

@JsonSerializable(createToJson: false)
class CategoryResponse {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'usage_count')
  final int? usageCount;

  CategoryResponse({required this.id, required this.name, this.usageCount});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) => _$CategoryResponseFromJson(json);
}
