import 'package:expense_tracker_mobile/data/models/response/login_response.dart';

class LoginDto {
  final String accessToken;

  LoginDto({required this.accessToken});

  // map login response to login dto
  factory LoginDto.fromLoginResponse(LoginResponse response) =>
      LoginDto(accessToken: response.accessToken);
}
