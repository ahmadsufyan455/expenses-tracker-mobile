import 'package:json_annotation/json_annotation.dart';

part 'base_pagination_response.g.dart';

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class BasePaginationResponse<T> {
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'total')
  final int total;
  @JsonKey(name: 'page')
  final int page;
  @JsonKey(name: 'per_page')
  final int perPage;
  @JsonKey(name: 'data')
  final List<T> data;

  BasePaginationResponse({
    required this.message,
    required this.total,
    required this.page,
    required this.perPage,
    required this.data,
  });

  factory BasePaginationResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BasePaginationResponseFromJson(json, fromJsonT);
}
