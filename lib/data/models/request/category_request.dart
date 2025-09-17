import 'package:json_annotation/json_annotation.dart';

part 'category_request.g.dart';

@JsonSerializable()
class CategoryRequest {
  @JsonKey(name: 'name')
  final String name;

  CategoryRequest({required this.name});

  Map<String, dynamic> toJson() => _$CategoryRequestToJson(this);
}
