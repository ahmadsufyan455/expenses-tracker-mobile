import 'package:equatable/equatable.dart';
import 'package:expense_tracker_mobile/core/errors/failure.dart';
import 'package:expense_tracker_mobile/data/models/request/change_password_request.dart';
import 'package:expense_tracker_mobile/data/models/request/update_profile_request.dart';
import 'package:expense_tracker_mobile/domain/dto/profile_dto.dart';
import 'package:expense_tracker_mobile/domain/usecases/change_password_usecase.dart';
import 'package:expense_tracker_mobile/domain/usecases/delete_account_usecase.dart';
import 'package:expense_tracker_mobile/domain/usecases/get_profile_usecase.dart';
import 'package:expense_tracker_mobile/domain/usecases/update_profile_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUsecase _getProfileUsecase;
  final UpdateProfileUsecase _updateProfileUsecase;
  final DeleteAccountUsecase _deleteAccountUsecase;
  final ChangePasswordUsecase _changePasswordUsecase;

  var stateData = ProfileStateData();

  ProfileBloc(
    this._getProfileUsecase,
    this._updateProfileUsecase,
    this._deleteAccountUsecase,
    this._changePasswordUsecase,
  ) : super(ProfileInitial()) {
    on<GetProfileEvent>(_onGetProfile);
    on<UpdateProfileEvent>(_onUpdateProfile);
    on<DeleteAccountEvent>(_onDeleteAccount);
    on<ChangePasswordEvent>(_onChangePassword);
  }

  Future<void> _onGetProfile(GetProfileEvent event, Emitter<ProfileState> emit) async {
    emit(GetProfileLoading(data: stateData));
    final result = await _getProfileUsecase.call();
    result.fold(
      (failure) {
        emit(GetProfileFailure(failure: failure, data: stateData));
      },
      (profile) {
        stateData = stateData.copyWith(profile: profile);
        emit(GetProfileSuccess(data: stateData));
      },
    );
  }

  Future<void> _onUpdateProfile(UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    emit(UpdateProfileLoading(data: stateData));
    final request = UpdateProfileRequest(
      firstName: event.firstName,
      lastName: event.lastName,
      email: event.email,
    );
    final result = await _updateProfileUsecase.call(request);
    result.fold(
      (failure) {
        emit(UpdateProfileFailure(failure: failure, data: stateData));
      },
      (message) {
        stateData = stateData.copyWith(message: message);
        emit(UpdateProfileSuccess(data: stateData));
      },
    );
  }

  Future<void> _onDeleteAccount(DeleteAccountEvent event, Emitter<ProfileState> emit) async {
    emit(DeleteAccountLoading(data: stateData));
    final result = await _deleteAccountUsecase.call();
    result.fold(
      (failure) {
        emit(DeleteAccountFailure(failure: failure, data: stateData));
      },
      (_) {
        emit(DeleteAccountSuccess(data: stateData));
      },
    );
  }

  Future<void> _onChangePassword(ChangePasswordEvent event, Emitter<ProfileState> emit) async {
    emit(ChangePasswordLoading(data: stateData));
    final request = ChangePasswordRequest(
      currentPassword: event.currentPassword,
      newPassword: event.newPassword,
    );
    final result = await _changePasswordUsecase.call(request);
    result.fold(
      (failure) {
        emit(ChangePasswordFailure(failure: failure, data: stateData));
      },
      (message) {
        stateData = stateData.copyWith(message: message);
        emit(ChangePasswordSuccess(data: stateData));
      },
    );
  }
}