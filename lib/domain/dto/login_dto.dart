import 'package:expense_tracker_mobile/data/models/response/login_response.dart';

class LoginDto {
  final String accessToken;
  final String tokenType;
  final int expiresIn;

  LoginDto({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
  });

  // map login response to login dto
  factory LoginDto.fromLoginResponse(LoginResponse response) => LoginDto(
        accessToken: response.accessToken,
        tokenType: response.tokenType,
        expiresIn: response.expiresIn,
      );
}
