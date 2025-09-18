import 'package:expense_tracker_mobile/data/models/response/profile_response.dart';

class ProfileDto {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String createdAt;
  final String updatedAt;

  ProfileDto({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProfileDto.fromResponse(ProfileResponse response) {
    return ProfileDto(
      id: response.id,
      email: response.email,
      firstName: response.firstName,
      lastName: response.lastName,
      createdAt: response.createdAt,
      updatedAt: response.updatedAt,
    );
  }

  String get fullName => '$firstName $lastName';
}