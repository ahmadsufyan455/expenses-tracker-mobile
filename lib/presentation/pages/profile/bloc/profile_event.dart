part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetProfileEvent extends ProfileEvent {
  const GetProfileEvent();

  @override
  List<Object> get props => [];
}

class UpdateProfileEvent extends ProfileEvent {
  final String firstName;
  final String lastName;
  final String email;

  const UpdateProfileEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  @override
  List<Object> get props => [firstName, lastName, email];
}

class DeleteAccountEvent extends ProfileEvent {
  const DeleteAccountEvent();

  @override
  List<Object> get props => [];
}

class ChangePasswordEvent extends ProfileEvent {
  final String currentPassword;
  final String newPassword;

  const ChangePasswordEvent({
    required this.currentPassword,
    required this.newPassword,
  });

  @override
  List<Object> get props => [currentPassword, newPassword];
}