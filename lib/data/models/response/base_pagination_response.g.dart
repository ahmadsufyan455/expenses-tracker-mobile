// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_pagination_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasePaginationResponse<T> _$BasePaginationResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => BasePaginationResponse<T>(
  message: json['message'] as String,
  total: (json['total'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  perPage: (json['per_page'] as num).toInt(),
  data: (json['data'] as List<dynamic>).map(fromJsonT).toList(),
);
