import 'package:equatable/equatable.dart';
import 'package:expense_tracker_mobile/core/errors/failure.dart';
import 'package:expense_tracker_mobile/data/models/request/login_request.dart';
import 'package:expense_tracker_mobile/domain/dto/login_dto.dart';
import 'package:expense_tracker_mobile/domain/usecases/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase loginUsecase;
  LoginBloc({required this.loginUsecase}) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    final request = LoginRequest(email: event.email, password: event.password);
    final result = await loginUsecase.call(request);
    result.fold(
      (failure) {
        emit(LoginFailure(failure: failure));
      },
      (data) {
        emit(LoginSuccess(data: data));
      },
    );
  }
}
