import 'package:json_annotation/json_annotation.dart';

part 'category_request.g.dart';

@JsonSerializable()
class CategoryRequest {
  final String name;

  CategoryRequest({required this.name});

  Map<String, dynamic> toJson() => _$CategoryRequestToJson(this);
}
