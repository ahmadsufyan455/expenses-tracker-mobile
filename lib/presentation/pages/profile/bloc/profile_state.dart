part of 'profile_bloc.dart';

class ProfileStateData extends Equatable {
  final ProfileDto? profile;
  final String message;

  const ProfileStateData({
    this.profile,
    this.message = '',
  });

  @override
  List<Object?> get props => [profile, message];

  ProfileStateData copyWith({
    ProfileDto? profile,
    String? message,
  }) {
    return ProfileStateData(
      profile: profile ?? this.profile,
      message: message ?? this.message,
    );
  }
}

sealed class ProfileState extends Equatable {
  final ProfileStateData data;
  const ProfileState({required this.data});

  @override
  List<Object> get props => [data];
}

final class ProfileInitial extends ProfileState {
  ProfileInitial() : super(data: ProfileStateData());
}

/// get profile
final class GetProfileLoading extends ProfileState {
  const GetProfileLoading({required super.data});
}

final class GetProfileSuccess extends ProfileState {
  const GetProfileSuccess({required super.data});
}

final class GetProfileFailure extends ProfileState {
  final Failure failure;

  const GetProfileFailure({required this.failure, required super.data});

  @override
  List<Object> get props => [failure];
}

/// update profile
final class UpdateProfileLoading extends ProfileState {
  const UpdateProfileLoading({required super.data});
}

final class UpdateProfileSuccess extends ProfileState {
  const UpdateProfileSuccess({required super.data});
}

final class UpdateProfileFailure extends ProfileState {
  final Failure failure;

  const UpdateProfileFailure({required this.failure, required super.data});

  @override
  List<Object> get props => [failure];
}

/// delete account
final class DeleteAccountLoading extends ProfileState {
  const DeleteAccountLoading({required super.data});
}

final class DeleteAccountSuccess extends ProfileState {
  const DeleteAccountSuccess({required super.data});
}

final class DeleteAccountFailure extends ProfileState {
  final Failure failure;

  const DeleteAccountFailure({required this.failure, required super.data});

  @override
  List<Object> get props => [failure];
}

/// change password
final class ChangePasswordLoading extends ProfileState {
  const ChangePasswordLoading({required super.data});
}

final class ChangePasswordSuccess extends ProfileState {
  const ChangePasswordSuccess({required super.data});
}

final class ChangePasswordFailure extends ProfileState {
  final Failure failure;

  const ChangePasswordFailure({required this.failure, required super.data});

  @override
  List<Object> get props => [failure];
}